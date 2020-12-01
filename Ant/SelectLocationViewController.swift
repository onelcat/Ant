//
//  SelectLocationViewController.swift
//  Ant
//
//  Created by flqy on 2020/12/1.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

fileprivate func reverseGeocodeLocation(_ location: CLLocation) -> Observable<[CLPlacemark]> {
//    22.543096 114.057865
    let tl = CLLocation(latitude: 22.55297293310582, longitude: 114.06023454101563)
    
    let observable = Observable<[CLPlacemark]>.create { (observer) -> Disposable in
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(tl) { (marks, error) in

            if let error = error {
                assert(false)
                observer.onError(error)
                return
            }

            guard let marks = marks else {
                let error = NSError(domain: "NO DATA", code: -1, userInfo: nil)
                observer.onError(error)
                assert(false)
                return
            }
            debugPrint("解析出来的地址数据", marks.count)
            observer.onNext(marks)
            observer.onCompleted()
            return
        }
        return Disposables.create()
    }
    return observable
}

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    private (set) var authorized: Driver<Bool>
    
    private (set) var location: Driver<CLLocation>
    
    private (set) var placemark: Driver<CLPlacemark>
    
    private let locationManager = CLLocationManager()
    
    public let didUpdateLocations: Observable<[CLLocation]>
    
    override init() {
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        // 判断权限
        authorized = Observable.deferred { [weak locationManager] in
                let status = CLLocationManager.authorizationStatus()
                guard let locationManager = locationManager else {
                    return Observable.just(status)
                }
                return locationManager
                    .rx.didChangeAuthorizationStatus
                    .startWith(status)
            }
            .asDriver(onErrorJustReturn: CLAuthorizationStatus.notDetermined)
            .map {
                switch $0 {
                case .authorizedAlways:
                    return true
                case .authorizedWhenInUse:
                    return true
                default:
                    return false
                }
            }
        
        didUpdateLocations = locationManager.rx.didUpdateLocations.share(replay: 1)
        
        self.location = didUpdateLocations
            .asDriver(onErrorJustReturn: [])
            .flatMap {
                return $0.first.map(Driver.just) ?? Driver.empty()
            }
        
        self.placemark = didUpdateLocations
            .asDriver(onErrorJustReturn: [])
            .flatMap {
                return $0.first.map(Driver.just) ?? Driver.empty()
            }
            .map{
                return reverseGeocodeLocation($0)
            }
            .flatMap{ $0.asDriver(onErrorJustReturn: []) }
            .flatMapFirst{
                return $0.first.map(Driver.just) ?? Driver.empty()
            }
    
    }
    
    func start() {
        switch CLLocationManager.authorizationStatus() {
        /// 用户尚未选择应用程序是否可以使用位置服务。
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        /// 该应用无权使用位置服务。
        case .restricted:
            // 直接提示没有权限
            break
        /// 用户拒绝为应用程序使用位置服务，或者在“设置”中全局禁用了这些服务。
        case .denied:
            // 提示设置窗口
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
        
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
    }
    

    
}

class SelectLocationViewController: UIViewController {

    @IBOutlet weak var selectedButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var thoroughfareTextField: UITextField!
    
    let disposeBag = DisposeBag()
    
    func getAddress(_ mark: CLPlacemark) {
        debugPrint(mark.administrativeArea,mark.subAdministrativeArea,mark.locality,mark.subLocality,mark.thoroughfare,mark.subThoroughfare)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 获取位置权限
        mapView.showsUserLocation = true
        
        LocationManager.shared.start()
        
        let location = LocationManager.shared.location
        
        let locationStr = location.map { (location) -> String in
            if location.horizontalAccuracy <= 30 {
                LocationManager.shared.stop()
            }
            return "\(location.coordinate.longitude),\(location.coordinate.latitude)"
        }
        
        locationStr.asObservable().subscribe { (locaiton) in
            debugPrint("获取解析到的位置", locaiton)
        } onError: { (error) in
            debugPrint("位置错误",error)
        } onCompleted: {
            debugPrint("位置更新完成")
        } onDisposed: {
            debugPrint("最后销毁")
        }.disposed(by: disposeBag)

        let mark = LocationManager.shared.placemark

        mark.asObservable().subscribe { [weak self] (event) in
//            guard let self = self else { return }
            switch event {
            case let .next(mark):
                self?.nameLabel.text = mark.name
                self?.getAddress(mark)
            case .error(_):
                debugPrint("数据解析错误")
            case .completed:
                debugPrint("数据解析完成")
            }
        }.disposed(by: disposeBag)
        
        let buttnoTap = selectedButton.rx.tap
        
        _ = buttnoTap.subscribe(onNext: { [weak self] _ in
            debugPrint("进行数据提交")
//            self.dismiss(animated: true, completion: nil)
            self?.dismiss(animated: true, completion: {
                // 这里还多 一些内存
//                self?.mapView?.removeFromSuperview()
//                self?.view.removeFromSuperview()
                self?.view = nil
                self = nil
            })
            
        }).disposed(by: disposeBag)
        
    }
    
    
}


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

fileprivate func reverseGeocodeLocation(_ location: CLLocation) -> Driver<[CLPlacemark]> {
    
    let observable = Observable<[CLPlacemark]>.create { (observer) -> Disposable in
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (marks, error) in

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
            debugPrint("获取到的位置数据", marks.first?.country ?? "没有解析出来数据")
            observer.onNext(marks)
            observer.onCompleted()
            return
        }
        return Disposables.create()
    }
    return observable.asDriver(onErrorJustReturn: [])
}

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    private (set) var authorized: Driver<Bool>
    
    private (set) var location: Driver<CLLocationCoordinate2D>
    
    private (set) var placemark: Driver<[CLPlacemark]>
    
    private let locationManager = CLLocationManager()
    
    public let didUpdateLocations: Observable<[CLLocation]>
    
    override init() {
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
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
        
        location = didUpdateLocations
            .asDriver(onErrorJustReturn: [])
            .flatMap {
                return $0.last.map(Driver.just) ?? Driver.empty()
            }
            .map { $0.coordinate }
        
        placemark = didUpdateLocations
            .asDriver(onErrorJustReturn: [])
            .flatMap {
                return $0.last.map(Driver.just) ?? Driver.empty()
            }
            .flatMap {
                return reverseGeocodeLocation($0)
            }
            .asDriver()
    
    }
    

    
    func start() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 获取位置权限
        mapView.showsUserLocation = true
        
        LocationManager.shared.start()
        
        let location = LocationManager.shared.location
        let locationStr = location.map { (location) -> String in
            return "\(location.longitude),\(location.latitude)"
        }
        locationStr.asObservable().subscribe { (locaiton) in
            debugPrint("获取解析到的位置", locaiton)
//            LocationManager.shared.stop()
        } onError: { (error) in
            debugPrint("位置错误",error)
        } onCompleted: {
            debugPrint("位置更新完成")
        } onDisposed: {
            debugPrint("徐爱欲")
        }.disposed(by: disposeBag)

        
        let mark = LocationManager.shared.placemark
        mark.asObservable().subscribe { (event) in
            switch event {
            
            case let .next(mark):
                debugPrint(mark.first?.country ?? "xx数据解析错误")
            case .error(_):
                debugPrint("数据解析错误")
            case .completed:
                debugPrint("完成数据解析")
            }
        }.disposed(by: disposeBag)
        
        let buttnoTap = selectedButton.rx.tap
        
        buttnoTap.subscribe(onNext: { _ in
            debugPrint("进行数据提交")
        })
        
    }
    
    
}

// 逆地址解析


class GeolocationService {
    
    static let instance = GeolocationService()
    private (set) var authorized: Driver<Bool>
    private (set) var location: Driver<CLLocationCoordinate2D>
    
    private let locationManager = CLLocationManager()
    
    private init() {
        
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
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
        
        location = locationManager.rx.didUpdateLocations
            .asDriver(onErrorJustReturn: [])
            .flatMap {
                return $0.last.map(Driver.just) ?? Driver.empty()
            }
            .map { $0.coordinate }
        
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

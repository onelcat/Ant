//
//  DevicePermissions.swift
//  HSExtension
//
//  Created by flqy on 2020/12/14.
//

import UIKit

import Photos

//MARK: 麦克风
protocol MicrophonePermission: UIAlertControllerPermission {
    func request(permission:(title: String?, message: String?), handler: @escaping ((_ authorizationStatus: Bool)->Void))
}

extension MicrophonePermission {
    func request(permission:(title: String?, message: String?), handler: @escaping ((_ authorizationStatus: Bool)->Void)) {
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { (granted) in
                if granted == false {
                    self.presentAlertControllerNoPermission(title: permission.title, message: permission.message)
                }
                handler(granted)
            }
        case .restricted: /// 您的应用无权访问照片库，并且用户无法授予此类权限。
            self.presentAlertControllerNoPermission(title: permission.title, message: permission.message)
            handler(false)
        case .denied:
            self.presentAlertControllerPermission(title: permission.title, message: permission.message)
            handler(false)
        case .authorized:
            handler(true)
        @unknown default:
            self.presentAlertControllerNoPermission(title: permission.title, message: permission.message)
            handler(false)
        }
    }
}

//MARK: 拍照
protocol CameraPermission: UIAlertControllerPermission {
    func request(permission:(title: String?, message: String?), handler: @escaping ((_ authorizationStatus: Bool)->Void))
}

extension CameraPermission {
    func request(permission:(title: String?, message: String?), handler: @escaping ((_ authorizationStatus: Bool)->Void)) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted == false {
                    self.presentAlertControllerNoPermission(title: permission.title, message: permission.message)
                }
                handler(granted)
            }
        case .restricted: /// 您的应用无权访问照片库，并且用户无法授予此类权限。
            self.presentAlertControllerNoPermission(title: permission.title, message: permission.message)
            handler(false)
        case .denied:
            self.presentAlertControllerPermission(title: permission.title, message: permission.message)
            handler(false)
        case .authorized:
            handler(true)
        @unknown default:
            self.presentAlertControllerNoPermission(title: permission.title, message: permission.message)
            handler(false)
        }
    }
}

//MARK: 相册
protocol PHPhotoLibraryPermission: UIAlertControllerPermission {
    func request(permission:(title: String?, message: String?), handler: @escaping ((_ authorizationStatus: Bool)->Void))
}

extension PHPhotoLibraryPermission {
    func request(permission:(title: String?, message: String?), handler: @escaping ((_ authorizationStatus: Bool)->Void)) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .notDetermined:
                    fatalError()
                case .restricted: /// 您的应用无权访问照片库，并且用户无法授予此类权限。
                    self.presentAlertControllerNoPermission(title: permission.title, message: permission.message)
                    handler(false)
                case .denied: /// 用户已明确拒绝您的应用访问照片库。
                    self.presentAlertControllerPermission(title: permission.title, message: permission.message)
                    handler(false)
                case .authorized:
                    handler(true)
                    break
                case .limited:
                    self.presentAlertControllerNoPermission(title: permission.title, message: permission.message)
                    handler(false)
                @unknown default:
                    self.presentAlertControllerNoPermission(title: permission.title, message: permission.message)
                    handler(false)
                }
            }
        case .restricted: /// 您的应用无权访问照片库，并且用户无法授予此类权限。
            self.presentAlertControllerNoPermission(title: permission.title, message: permission.message)
            handler(false)
        case .denied: /// 用户已明确拒绝您的应用访问照片库。
            self.presentAlertControllerPermission(title: permission.title, message: permission.message)
            handler(false)
        case .authorized:
            handler(true)
        case .limited:
            self.presentAlertControllerNoPermission(title: permission.title, message: permission.message)
            handler(false)
        @unknown default:
            self.presentAlertControllerNoPermission(title: permission.title, message: permission.message)
            handler(false)
        }
    }
}

// MARK: 定位
import CoreLocation
protocol LocationPermission {
    func request(permission:(title: String?, message: String?), handler: @escaping ((_ authorizationStatus: Bool)->Void))
}

extension LocationPermission {
    func request(permission:(title: String?, message: String?), handler: @escaping ((_ authorizationStatus: Bool)->Void)) {
        fatalError("需要自己实现")
//        CLLocationManager.authorizationStatus()
//        CLLocationManager.requestAlwaysAuthorization(<#T##self: CLLocationManager##CLLocationManager#>)
//        CLLocationManager.requestWhenInUseAuthorization(<#T##self: CLLocationManager##CLLocationManager#>)
    }
}

//MARK: 健康与健身
import HealthKit

protocol HealthPermission {
    func request(permission:(title: String?, message: String?), handler: @escaping ((_ authorizationStatus: Bool)->Void))
}

extension HealthPermission {
    func request(permission:(title: String?, message: String?), handler: @escaping ((_ authorizationStatus: Bool)->Void)) {
        fatalError("需要自己实现")
//        let healthStore = HKHealthStore()
//
//        guard HKHealthStore.isHealthDataAvailable() else {
//            // FIXME: 不支持功能
//            handler(false)
//            return
//        }
//
//        let allTypes = Set([HKObjectType.workoutType(),
//                            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
//                            HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
//                            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
//                            HKObjectType.quantityType(forIdentifier: .heartRate)!])
//
//
//        if #available(iOS 12.0, *) {
//            healthStore.getRequestStatusForAuthorization(toShare: allTypes, read: allTypes) { (status, error) in
//
//
//                switch status {
//                case .unknown:
//                    break
//                case .shouldRequest:
//                    // 进行请求
//                    break
//                case .unnecessary:
//                    break
//                @unknown default:
//                    break
//                }
//            }
//        } else {
//            // Fallback on earlier versions
//            let status = healthStore.authorizationStatus(for: .activitySummaryType())
//            switch status {
//            case .notDetermined:
//                break
//            case .sharingDenied:
//                break
//            case .sharingAuthorized:
//                break
//            @unknown default:
//                break
//            }
//        }
//
//        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
//            if !success {
//                // Handle the error here.
//            }
//        }
//
    }
}

// 通知




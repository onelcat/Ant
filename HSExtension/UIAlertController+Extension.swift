//
//  UIAlertController+Extension.swift
//  HSExtension
//
//  Created by flqy on 2020/12/14.
//

import Foundation
import UIKit

protocol UIAlertControllerPermission: UIViewController {
    func presentAlertControllerPermission(title: String?, message: String?)
    func presentAlertControllerNoPermission(title: String?, message: String?)
}

extension UIAlertControllerPermission {
    
    func presentAlertControllerPermission(title: String?, message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
         
        let cancelAction = UIAlertAction(title:"取消", style: .cancel, handler:nil)
        let settingsAction = UIAlertAction(title:"设置", style: .default, handler: {
            (action) -> Void in
            let url = URL(string: UIApplication.openSettingsURLString)
            if let url = url, UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:],
                                              completionHandler: {
                                                (success) in
                    })
                } else {
                   UIApplication.shared.openURL(url)
                }
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func presentAlertControllerNoPermission(title: String?, message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
         
        let cancelAction = UIAlertAction(title:"确定", style: .cancel, handler:nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


protocol UIAlertControllerExtension: UIViewController {
    
    func presentAlertControllerPermission(title: String, message: String)
    
    func presentAlertController(title: String?, message: String?,preferredStyle: UIAlertController.Style, actions: [(title: String?,style: UIAlertAction.Style)], handler: ((Int) -> Void)?)
    
    func presentAlertControllerAlert(title: String?, message: String?, actions: [(title: String?,style: UIAlertAction.Style)], handler: ((Int) -> Void)?)
    
    func presentAlertControllerActionSheet(title: String?, message: String?, actions: [(title: String?,style: UIAlertAction.Style)], handler: ((Int) -> Void)?)
    
}

extension UIAlertControllerExtension {
    
    func presentAlertControllerPermission(title: String?, message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
         
        let cancelAction = UIAlertAction(title:"取消", style: .cancel, handler:nil)
        let settingsAction = UIAlertAction(title:"设置", style: .default, handler: {
            (action) -> Void in
            let url = URL(string: UIApplication.openSettingsURLString)
            if let url = url, UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:],
                                              completionHandler: {
                                                (success) in
                    })
                } else {
                   UIApplication.shared.openURL(url)
                }
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlertController(title: String?, message: String?,preferredStyle: UIAlertController.Style, actions: [(title: String?,style: UIAlertAction.Style)], handler: ((Int) -> Void)?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: preferredStyle)
        for (i,item) in actions.enumerated() {
            let action = UIAlertAction(title: item.title, style: item.style) { (_) in
                handler?(i)
            }
            alertController.addAction(action)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlertControllerAlert(title: String?, message: String?, actions: [(title: String?,style: UIAlertAction.Style)], handler: ((Int) -> Void)?) {
        self.presentAlertController(title: title, message: message, preferredStyle: .alert, actions: actions, handler: handler)
    }
    
    func presentAlertControllerActionSheet(title: String?, message: String?, actions: [(title: String?,style: UIAlertAction.Style)], handler: ((Int) -> Void)?) {
        
        self.presentAlertController(title: title, message: message, preferredStyle: .actionSheet, actions: actions, handler: handler)
    }
    
}

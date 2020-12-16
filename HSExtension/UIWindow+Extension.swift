//
//  UIWindow+Extension.swift
//  HSExtension
//
//  Created by flqy on 2020/12/14.
//

import Foundation
import UIKit

extension UIWindow {
    class var currentWindow: UIWindow? {
        if let delegate = UIApplication.shared.delegate,
           delegate.responds(to: #selector(getter: delegate.window)),
           let window = delegate.window {
            return window
        }
        let windows = UIApplication.shared.windows
        if windows.count == 1 {
            return windows.first
        }
        else {
            for window in windows {
                if window.windowLevel == .normal {
                    return window
                }
            }
        }
        return nil
    }
}

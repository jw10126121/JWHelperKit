//
//  UIViewController+Navigation.swift
//  MDAlarmClockApp
//
//  Created by xiaobin liu on 2017/9/18.
//  Copyright © 2017年 Linjw. All rights reserved.
//

import Foundation
import UIKit

public extension JWNamespaceWrapper where T: UIViewController {
    
    /// 获取活动的VC
    static var topMost: UIViewController? {
        
        return self.topViewController(with: self.currentWindow()?.rootViewController)
    }

    /// 找到当前显示的UIWindow
    fileprivate static func currentWindow() -> UIWindow? {
        
        var window: UIWindow? = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            for tempWindow in UIApplication.shared.windows.reversed() {
                if tempWindow.windowLevel == UIWindow.Level.normal {
                    window = tempWindow
                    break
                }
            }
        }
        return window
    }
    
    ///
    fileprivate static func topViewController(with vc: UIViewController?) -> UIViewController? {
        
        guard let viewController = vc else { return nil }
        
        if let presented = viewController.presentedViewController {
            return self.topViewController(with: presented)
        } else if let tab = viewController as? UITabBarController {
            return self.topViewController(with: tab.selectedViewController)
        } else if let nav = viewController as? UINavigationController {
            return self.topViewController(with: nav.visibleViewController)
        } else {
            return viewController
        }
    }
    
}

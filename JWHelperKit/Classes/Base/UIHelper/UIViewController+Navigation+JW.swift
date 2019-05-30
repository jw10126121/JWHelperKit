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
        //        return self.currentVC()
        //        return self.topMost(of: UIApplication.shared.windows.first?.rootViewController)  // 不太准
    }
    
    fileprivate static func currentVC() -> UIViewController? {
        
        for window in UIApplication.shared.windows.reversed() {
            
            if window.windowLevel != UIWindow.Level.normal { continue }
            
            var tempView: UIView? = window.subviews.last
            for subview in window.subviews.reversed() {
                if subview.classForCoder == NSClassFromString("UILayoutContainerView") {
                    tempView = subview
                    break
                }
            }
            
            var nextResponder = tempView?.next
            
            var next: Bool {
                return !(nextResponder is UIViewController) || nextResponder is UINavigationController || nextResponder is UITabBarController || nextResponder?.classForCoder == NSClassFromString("UIInputWindowController")
            }
            
            while next {
                tempView = tempView?.subviews.first
                if tempView == nil { return nil }
                nextResponder = tempView!.next
            }
            if let currentVC = nextResponder as? UIViewController {
                return currentVC
            }
        }
        return nil
    }
    
    /// 获取活动的VC (暂不用)
    fileprivate static func topMost(of viewController: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        
        if let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return self.topMost(of: selectedViewController)
        }
        
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return self.topMost(of: visibleViewController)
        }
        
        if let presentedViewController = viewController?.presentedViewController {
            return self.topMost(of: presentedViewController)
        }
        
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return self.topMost(of: childViewController)
            }
        }
        
        return viewController
    }
    
    // 找到当前显示的UIWindow
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

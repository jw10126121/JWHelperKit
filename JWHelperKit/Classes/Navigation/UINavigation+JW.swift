//
//  UINavigation+JW.swift
//  ToMakeMoney
//
//  Created by LjwMac on 2018/1/15.
//  Copyright © 2018年 jw. All rights reserved.
//

import Foundation
import UIKit

/// 拓展导航条
public extension JWNamespaceWrapper where T: UINavigationController {
    
    /// 获取KeyWindow下的rootViewController
    static func rootViewController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    
    /// present
    static func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        DispatchQueue.main.async {
            guard let fromViewController = UINavigationController.jw.topMost else { return }
            fromViewController.present(viewController, animated: animated, completion: completion)
        }
    }
    
    /// dismiss
    static func dismiss(animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        DispatchQueue.main.async {
            guard let fromViewController = UINavigationController.jw.topMost else { return }
            fromViewController.view.endEditing(true)
            fromViewController.dismiss(animated: animated, completion: completion)
        }
    }
    
    /// showDetail
    static func showDetail(_ viewController: UIViewController, sender: Any?) {
        DispatchQueue.main.async {
            guard let fromViewController = UINavigationController.jw.topMost else { return }
            fromViewController.showDetailViewController(viewController, sender: sender)
        }
    }
    
}

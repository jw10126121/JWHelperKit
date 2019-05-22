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
    
    static func autoDismiss(animated: Bool = true) {
        
        DispatchQueue.main.async {
            
            guard let currentVC = UIViewController.jw.topMost else { return }
            
            if let count = currentVC.navigationController?.children.count, count > 1 {
                self.pop(animated)
            } else {
                self.dismiss(animated: animated, completion: nil)
            }
        }
        
    }
    
    static func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        DispatchQueue.main.async {
            guard let fromViewController = UIViewController.jw.topMost else { return  }
            fromViewController.present(viewController, animated: animated, completion: completion)
        }
    }
    
    static func dismiss(animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        DispatchQueue.main.async {
            guard let fromViewController = UIViewController.jw.topMost else { return  }
            fromViewController.view.endEditing(true)
            fromViewController.dismiss(animated: animated, completion: completion)
        }
    }
    
    static func showDetail(_ viewController: UIViewController, sender: Any?) {
        DispatchQueue.main.async {
            guard let fromViewController = UIViewController.jw.topMost else { return  }
            fromViewController.showDetailViewController(viewController, sender: sender)
        }
    }
    
    static func rootViewController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    
}



//
//  UIViewController+Navigation+JW+Completion.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2018/11/10.
//  Copyright © 2018 Linjw. All rights reserved.
//

import UIKit
import UINavigationControllerWithCompletionBlock

/// 拓展导航条
public extension JWNamespaceWrapper where T: UINavigationController {
    
    static func push(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        
        let top = UIViewController.jw.topMost
        
        guard let navigationController = top?.navigationController else {
            return
        }
        viewController.hidesBottomBarWhenPushed = true
        
        navigationController.pushViewController(viewController, animated: animated, withCompletionBlock: completion)
        
    }
    
    static func pop(_ animated: Bool = true, completion: (() -> Void)? = nil) {
        
        let top = UIViewController.jw.topMost
        
        guard let navigationController = top?.navigationController else { return }
        
        navigationController.popViewController(animated: animated, withCompletionBlock: completion)
    }
    
    static func popToRoot(_ animated: Bool = true, completion: (() -> Void)? = nil) {
        
        guard let navigationController = UIViewController.jw.topMost?.navigationController else { return }
        
        navigationController.popToRootViewController(animated: animated, withCompletionBlock: completion)
    }
    
    static func popTo(_ toVC: UIViewController, animated: Bool = true) {
        
        let top = UIViewController.jw.topMost
        
        guard let navigationController = top?.navigationController else { return }
        
        navigationController.popToViewController(toVC, animated: animated)
        
    }
    
//    public static func push(_ viewController: UIViewController, animated: Bool = true) {
//        let top = UIViewController.jw.topMost
//        guard let navigationController = top?.navigationController else {
//            return
//        }
//        viewController.hidesBottomBarWhenPushed = true
//        navigationController.pushViewController(viewController, animated: animated)
//    }
//
//    public static func pop(_ animated: Bool = true) {
//        guard let navigationController = UIViewController.jw.topMost?.navigationController else {
//            return
//        }
//        navigationController.popViewController(animated: animated)
//    }
//
//    public static func popToRoot(_ animated: Bool = true) {
//        guard let navigationController = UIViewController.jw.topMost?.navigationController else {
//            return
//        }
//        navigationController.popToRootViewController(animated: animated)
//    }

    
}

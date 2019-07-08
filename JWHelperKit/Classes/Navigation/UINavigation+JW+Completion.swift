//
//  UIViewController+Navigation+JW+Completion.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2018/11/10.
//  Copyright © 2018 Linjw. All rights reserved.
//

import UIKit
//import UINavigationControllerWithCompletionBlock

/// 拓展导航条
public extension JWNamespaceWrapper where T: UINavigationController {
    
    static func autoDismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        
        DispatchQueue.main.async {
            
            guard let currentVC = UINavigationController.jw.topMost else { return }
            
            if let count = currentVC.navigationController?.children.count, count > 1 {
                self.pop(animated, completion: completion)
            } else {
                self.dismiss(animated: animated, completion: completion)
            }
        }
        
    }
    
    static func push(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        
        let top = UINavigationController.jw.topMost
        
        guard let navigationController = top?.navigationController else {
            return
        }
        viewController.hidesBottomBarWhenPushed = true
        
//        navigationController.pushViewController(viewController, animated: animated, withCompletionBlock: completion)
        
        navigationController.jwPushViewController(viewController, animated: animated, completion: completion)
    }
    
    static func pop(_ animated: Bool = true, completion: (() -> Void)? = nil) {
        
        let top = UINavigationController.jw.topMost
        
        guard let navigationController = top?.navigationController else { return }
        
//        navigationController.popViewController(animated: animated, withCompletionBlock: completion)
        navigationController.jwPopViewController(animated: animated, completion: completion)
    }
    
    static func popToRoot(_ animated: Bool = true, completion: (() -> Void)? = nil) {
        
        guard let navigationController = UINavigationController.jw.topMost?.navigationController else { return }
        
//        navigationController.popToRootViewController(animated: animated, withCompletionBlock: completion)
        navigationController.jwPopToRootViewController(animated: animated, completion: completion)
    }
    
    static func popTo(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        
        let top = UINavigationController.jw.topMost
        
        guard let navigationController = top?.navigationController else { return }
        
//        navigationController.popToViewController(toVC, animated: animated)
        navigationController.jwPopToViewController(viewController, animated: animated, completion: completion)
    }
    
}

/// 导航条Push/Pop
fileprivate extension UINavigationController {
    
    /// 带completion的Push方法
    func jwPushViewController(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        
        /// 设置动画完成回调
        CATransaction.setCompletionBlock(completion)
        
        CATransaction.begin()
        
        self.pushViewController(viewController, animated: animated)
        
        CATransaction.commit()
        
    }
    
    /// 带completion的Pop方法
    func jwPopViewController(animated: Bool = true, completion: (() -> Void)? = nil) -> UIViewController? {
        
        /// 设置动画完成回调
        CATransaction.setCompletionBlock(completion)
        
        CATransaction.begin()
        
        let poped = self.popViewController(animated: animated)
        
        CATransaction.commit()
        
        return poped
        
    }
    
    /// 带completion的Pop方法
    func jwPopToViewController(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) -> [UIViewController]? {
        
        /// 设置动画完成回调
        CATransaction.setCompletionBlock(completion)
        
        CATransaction.begin()
        
        let poped = self.popToViewController(viewController, animated: animated)
        
        CATransaction.commit()
        
        return poped
        
    }
    
    /// 带completion的Pop方法
    func jwPopToRootViewController(animated: Bool = true, completion: (() -> Void)? = nil) -> [UIViewController]? {
        
        /// 设置动画完成回调
        CATransaction.setCompletionBlock(completion)
        
        CATransaction.begin()
        
        let poped = self.popToRootViewController(animated: animated)
        
        CATransaction.commit()
        
        return poped
        
    }
    
    
}

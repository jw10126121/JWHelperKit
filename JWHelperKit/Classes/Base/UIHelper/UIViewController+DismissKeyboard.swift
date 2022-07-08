//
//  UIViewController+DismissKeyboard.swift
//  TW
//
//  Created by xiaobin liu on 2018/10/24.
//  Copyright © 2018年 Sky. All rights reserved.
//

import UIKit

public extension JWNamespaceWrapper where T: UIViewController {
    
    /// 设置点击背景隐藏键盘
    func setupForDismissKeyboard() { jwWrappedValue.setupForDismissKeyboard() }
    
}

fileprivate extension UIViewController {
    
    /// 设置隐藏键盘
    func setupForDismissKeyboard() {
        
        let nc = NotificationCenter.default
        let singleTapGR = UITapGestureRecognizer(target: self, action: #selector(tapAnywhereToDismissKeyboard(_:)))
        
        weak var weakSelf: UIViewController? = self
        let mainQuene = OperationQueue.main
        nc.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: mainQuene, using: { _ in
            weakSelf?.view.addGestureRecognizer(singleTapGR)
        })
        nc.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: mainQuene, using: { _ in
            weakSelf?.view.removeGestureRecognizer(singleTapGR)
        })
    }
    
    @objc func tapAnywhereToDismissKeyboard(_ gest: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

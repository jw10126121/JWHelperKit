//
//  UITextfield+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2018/8/23.
//  Copyright © 2018年 Linjw. All rights reserved.
//

import UIKit



public extension JWNamespaceWrapper where T == UITextField {
    
    
    
    /// 添加左边Icon
    func addPaddingLeftIcon(_ image: UIImage?, padding: CGFloat, mode: UITextField.ViewMode = .always) {
        
        if jwWrappedValue.leftView as? UIImageView == nil {
            
            let imageView = UIImageView(image: image)
            imageView.contentMode = .center
            jwWrappedValue.leftView = imageView
            jwWrappedValue.leftViewMode = mode
        }
        
        jwWrappedValue.leftView?.frame.size = CGSize(width: image?.size.width ?? 0 + padding, height: image?.size.height ?? 1)

    }
    
    /// 添加右边Icon
    func addPaddingRightIcon(_ image: UIImage?, padding: CGFloat, mode: UITextField.ViewMode = .always) {
        
        if jwWrappedValue.leftView as? UIImageView == nil {
            
            let imageView = UIImageView(image: image)
            imageView.contentMode = .center
            jwWrappedValue.clearButtonMode = .never
            jwWrappedValue.rightView = imageView
            jwWrappedValue.rightViewMode = mode
        }
        
        jwWrappedValue.rightView?.frame.size = CGSize(width: image?.size.width ?? 0 + padding, height: image?.size.height ?? 1)
        
    }
    
    
}


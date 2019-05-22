//
//  UIStackView+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2019/3/8.
//  Copyright © 2019 Linjw. All rights reserved.
//

import UIKit

/// 拓展 UIStackView
public extension JWNamespaceWrapper where T: UIStackView {
    
    /// 添加视图
    func addArrangedSubviews(_ views: UIView...) {
        for view in views { jwWrappedValue.addArrangedSubview(view) }
    }
    
    /// 移除视图
    func removeArrangedSubviews(_ views: UIView...) {
        for view in views {
            if view.superview == jwWrappedValue {
                jwWrappedValue.removeArrangedSubview(view)
            }
        }
    }
    
    
    
}



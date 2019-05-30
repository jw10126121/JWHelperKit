//
//  UIScrollView+JW.swift
//  ToMakeMoney
//
//  Created by LjwMac on 2018/1/15.
//  Copyright © 2018年 jw. All rights reserved.
//

import UIKit

/// UIScrollView拓展
public extension JWNamespaceWrapper where T: UIScrollView {
    
    /// 设置ScrollView Insets 自动调整(iOS11以下，需要在ScrollView添加到viewController上才能用)
    func contentInsetAdjustmentBehaviorAutomatic(_ isAuto: Bool) {
        
        if #available(iOS 11.0, *) {
            jwWrappedValue.contentInsetAdjustmentBehavior = (isAuto ? .automatic : .never)
        } else if jwWrappedValue.jw.viewController?.automaticallyAdjustsScrollViewInsets != isAuto {
            jwWrappedValue.jw.viewController?.automaticallyAdjustsScrollViewInsets = isAuto
        }
        
    }
    
    /// 是否在底部
    func isAtBottom() -> Bool {
        let bottomOffset = self.jwWrappedValue.contentSize.height - self.jwWrappedValue.bounds.size.height + self.jwWrappedValue.contentInset.bottom + self.jwWrappedValue.contentInset.top
        return self.jwWrappedValue.contentOffset.y == bottomOffset
    }
    
    /// 判断能不能滚动到底部
    func canScrollToBottom() -> Bool {
        if (jwWrappedValue.contentSize.height + jwWrappedValue.contentInset.bottom + jwWrappedValue.contentInset.top > jwWrappedValue.bounds.size.height) {
            return true
        }
        return false
    }
    
    /// 滚动到底部
    func scrollToBottom(animated: Bool) {
        if !self.isAtBottom() && self.canScrollToBottom() {
            let bottomOffsetY = self.jwWrappedValue.contentSize.height - self.jwWrappedValue.bounds.size.height + self.jwWrappedValue.contentInset.bottom + self.jwWrappedValue.contentInset.top
            
            let bottomOffset = CGPoint(x: 0.0, y: bottomOffsetY)
            self.jwWrappedValue.setContentOffset(bottomOffset, animated: animated)
        }
    }
    
}

/// 当使用setter方法时，对象本身必须是使用var声明的，即是变量
public extension JWNamespaceWrapper where T: UIScrollView {

    var contentWidth: CGFloat {
        get {
            return jwWrappedValue.contentSize.width
        }
        
        set {
            jwWrappedValue.contentSize.width = newValue
        }
    }
    
    var contentHeight: CGFloat {
        get {
            return jwWrappedValue.contentSize.height
        }
        
        set {
            jwWrappedValue.contentSize.height = newValue
        }
    }
    
    var contentOffsetX: CGFloat {
        get {
            return jwWrappedValue.contentOffset.x
        }
        
        set {
            jwWrappedValue.contentOffset.x = newValue
        }
    }
    
    var contentOffsetY: CGFloat {
        get {
            return jwWrappedValue.contentOffset.y
        }
        
        set {
            jwWrappedValue.contentOffset.y = newValue
        }
    }
    
}

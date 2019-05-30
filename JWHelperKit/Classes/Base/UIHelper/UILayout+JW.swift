//
//  UILayout+JW.swift
//  
//
//  Created by Linjw on 2018/8/3.
//  Copyright © 2018年 Linjw. All rights reserved.
//

import UIKit

/// NSLayoutConstraint.fix
@IBDesignable public extension NSLayoutConstraint {
    
    /// 偏移导航栏条高度
    @IBInspectable var autoOffsetNavBarHeight: Bool {
        
        get { return self._isAutoOffsetNavBarHeight }
        
        set {
            if newValue && !self._isAutoOffsetNavBarHeight {
                self._isAutoOffsetNavBarHeight = true
                self.constant = self.constant + CGFloat(UIDevice.jw.navBarHeight)
            } else if !newValue && self._isAutoOffsetNavBarHeight {
                self._isAutoOffsetNavBarHeight = false
                self.constant = self.constant - CGFloat(UIDevice.jw.navBarHeight)
            }
        }
    }
    
    /// 偏移状态栏高度
    @IBInspectable var autoOffsetStateBarHeight: Bool {
        
        get { return self._isAutoOffsetStateBarHeight }
        
        set {
            if newValue && !self._isAutoOffsetStateBarHeight {
                self._isAutoOffsetStateBarHeight = true
                self.constant = self.constant + CGFloat(UIDevice.jw.statusBarHeight)
            } else if !newValue && self._isAutoOffsetStateBarHeight {
                self._isAutoOffsetStateBarHeight = false
                self.constant = self.constant - CGFloat(UIDevice.jw.statusBarHeight)
            }
        }
    }
    
    /// 基于宽度等比缩放
    @IBInspectable var autoFixScale: Bool {
        
        get { return self._autoScale }
        
        set {
            if newValue && !self._autoScale {
                self._autoScale = true
                self.constant = self.constant * CGFloat(UIDevice.jw.screenWidthScale)
            } else if !newValue && self._autoScale {
                self._autoScale = false
                self.constant = self.constant / CGFloat(UIDevice.jw.screenWidthScale)
            }
        }
    }
    
}

// NSLayoutConstraint.Runtime
fileprivate extension NSLayoutConstraint {
    
    struct NSLayoutConstraintRTKeys {
        static var KeyForAutoOffsetNavBarHeight = "KeyForAutoOffsetNavBarHeight"
        static var KeyForAutoOffsetStateBarHeight = "KeyForAutoOffsetStateBarHeight"
        static var KeyForAutoScale = "KeyForAutoScale"
    }
    
    var _isAutoOffsetStateBarHeight: Bool {
        get {
            return objc_getAssociatedObject(self, &NSLayoutConstraintRTKeys.KeyForAutoOffsetNavBarHeight) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &NSLayoutConstraintRTKeys.KeyForAutoOffsetNavBarHeight, newValue as Bool?, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN
            )
        }
    }
    
    var _isAutoOffsetNavBarHeight: Bool {
        get {
            return objc_getAssociatedObject(self, &NSLayoutConstraintRTKeys.KeyForAutoOffsetNavBarHeight) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &NSLayoutConstraintRTKeys.KeyForAutoOffsetNavBarHeight, newValue as Bool?, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN
            )
        }
    }
    
    var _autoScale: Bool {
        get {
            return objc_getAssociatedObject(self, &NSLayoutConstraintRTKeys.KeyForAutoScale) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &NSLayoutConstraintRTKeys.KeyForAutoScale, newValue as Bool?, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN
            )
        }
    }
}

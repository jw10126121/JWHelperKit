//
//  UIButton+MD.swift
//  MDAlarmClockApp
//
//  Created by xiaobin liu on 2017/9/15.
//  Copyright © 2017年 Linjw. All rights reserved.
//

import Foundation
import UIKit

public extension UIButton {
    
    @IBInspectable
    var jwFont: UIFont? {
        get {
            return titleLabel?.font
        }
        set {
            titleLabel?.font = newValue
        }
    }
    
    @IBInspectable
    var imageForDisabled: UIImage? {
        get {
            return image(for: .disabled)
        }
        set {
            setImage(newValue, for: .disabled)
        }
    }
    
    @IBInspectable
    var imageForHighlighted: UIImage? {
        get {
            return image(for: .highlighted)
        }
        set {
            setImage(newValue, for: .highlighted)
        }
    }
    
    @IBInspectable
    var imageForNormal: UIImage? {
        get {
            return image(for: .normal)
        }
        set {
            setImage(newValue, for: .normal)
        }
    }
    
    @IBInspectable
    var imageForSelected: UIImage? {
        get {
            return image(for: .selected)
        }
        set {
            setImage(newValue, for: .selected)
        }
    }
    
    @IBInspectable
    var titleColorForDisabled: UIColor? {
        get {
            return titleColor(for: .disabled)
        }
        set {
            setTitleColor(newValue, for: .disabled)
        }
    }
    
    @IBInspectable
    var titleColorForHighlighted: UIColor? {
        get {
            return titleColor(for: .highlighted)
        }
        set {
            setTitleColor(newValue, for: .highlighted)
        }
    }
    
    @IBInspectable
    var titleColorForNormal: UIColor? {
        get {
            return titleColor(for: .normal)
        }
        set {
            setTitleColor(newValue, for: .normal)
        }
    }
    
    @IBInspectable
    var titleColorForSelected: UIColor? {
        get {
            return titleColor(for: .selected)
        }
        set {
            setTitleColor(newValue, for: .selected)
        }
    }
    
    @IBInspectable
    var titleForDisabled: String? {
        get {
            return title(for: .disabled)
        }
        set {
            setTitle(newValue, for: .disabled)
        }
    }
    
    @IBInspectable
    var titleForHighlighted: String? {
        get {
            return title(for: .highlighted)
        }
        set {
            setTitle(newValue, for: .highlighted)
        }
    }
    
    @IBInspectable
    var titleForNormal: String? {
        get {
            return title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }
    
    @IBInspectable
    var titleForSelected: String? {
        get {
            return title(for: .selected)
        }
        set {
            setTitle(newValue, for: .selected)
        }
    }
    
    @IBInspectable
    var backgroundImageNormal: UIImage? {
        
        get {
            return backgroundImage(for: .normal)
        }
        set {
            setBackgroundImage(newValue, for: .normal)
        }
    }
    
    @IBInspectable
    var backgroundImageSelected: UIImage? {
        
        get {
            return backgroundImage(for: .selected)
        }
        set {
            setBackgroundImage(newValue, for: .selected)
        }
    }
    
    @IBInspectable
    var backgroundImageDisabled: UIImage? {
        
        get {
            return backgroundImage(for: .disabled)
        }
        set {
            setBackgroundImage(newValue, for: .disabled)
        }
    }
    
}

// MARK: - 按钮扩展风格
public extension JWNamespaceWrapper where T: UIButton {
    
    func titleImageHorizontalAlignmentwith(_ space: Int) {
        
        self.resetEdgeInsets()
        
        jwWrappedValue.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat(space))
        
        jwWrappedValue.setNeedsLayout()
        jwWrappedValue.layoutIfNeeded()
        
        let contentRect = jwWrappedValue.contentRect(forBounds: jwWrappedValue.bounds)
        let titleSize = jwWrappedValue.titleRect(forContentRect: contentRect).size
        let imageSize = jwWrappedValue.imageRect(forContentRect: contentRect).size
        
        jwWrappedValue.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: 0, right: imageSize.width)
        jwWrappedValue.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width + CGFloat(space), bottom: 0, right: -titleSize.width - CGFloat(space))
        
    }
    
    func imageTitleHorizontalAlignmentWith(_ space: Int) {
        
        self.resetEdgeInsets()
        jwWrappedValue.titleEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat(space), bottom: 0, right: -CGFloat(space))
        jwWrappedValue.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat(space))
    }
    
    func titleImageVerticalAlignmentWith(_ space: Int) {
        
        self.verticalAlignmentWithTitle(true, space: space)
    }
    
    func imageTitleVerticalAlignmentWith(_ space: Int) {
        self.verticalAlignmentWithTitle(false, space: space)
    }
    
    fileprivate func verticalAlignmentWithTitle(_ isTop: Bool, space: Int) {
        
        self.resetEdgeInsets()
        
        jwWrappedValue.setNeedsLayout()
        jwWrappedValue.layoutIfNeeded()
        
        let contentRect = jwWrappedValue.contentRect(forBounds: jwWrappedValue.bounds)
        let titleSize = jwWrappedValue.titleRect(forContentRect: contentRect).size
        let imageSize = jwWrappedValue.imageRect(forContentRect: contentRect).size
        
        let halfWidth = (titleSize.width + imageSize.width) / 2
        let halfHeight = (titleSize.height + imageSize.height) / 2
        
        let topInset = min(halfHeight, titleSize.height)
        let leftInset = (titleSize.width - imageSize.width) > 0 ? (titleSize.width - imageSize.width) / 2 : 0
        let bottomInset = (titleSize.height - imageSize.height) > 0 ? (titleSize.height - imageSize.height) / 2 : 0
        let rightInset = min(halfWidth, titleSize.width)
        
        if isTop {
            jwWrappedValue.titleEdgeInsets = UIEdgeInsets(top: -halfHeight - CGFloat(space), left: -halfWidth, bottom: halfHeight + CGFloat(space), right: halfWidth)
            jwWrappedValue.contentEdgeInsets = UIEdgeInsets(top: topInset + CGFloat(space), left: leftInset, bottom: -bottomInset, right: -rightInset)
        } else {
            jwWrappedValue.titleEdgeInsets = UIEdgeInsets(top: halfHeight + CGFloat(space), left: -halfWidth, bottom: -halfHeight - CGFloat(space), right: halfWidth)
            jwWrappedValue.contentEdgeInsets = UIEdgeInsets(top: -bottomInset, left: leftInset, bottom: topInset + CGFloat(space), right: -rightInset)
        }
    }
    
    func resetEdgeInsets() {
        jwWrappedValue.contentEdgeInsets = UIEdgeInsets.zero
        jwWrappedValue.imageEdgeInsets = UIEdgeInsets.zero
        jwWrappedValue.titleEdgeInsets = UIEdgeInsets.zero
    }
    
}

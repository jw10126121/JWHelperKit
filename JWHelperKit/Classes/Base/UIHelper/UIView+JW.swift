//
//  UIView+Frame.swift
//  MDAlarmClockApp
//
//  Created by xiaobin liu on 2017/9/16.
//  Copyright © 2017年 Linjw. All rights reserved.
//

import UIKit

// MARK: - UIView 扩展
public extension JWNamespaceWrapper where T: UIView {
    
    /// 获取当前View所在的ViewController
    var viewController: UIViewController? {
        var next = jwWrappedValue.next
        while next != nil {
            if next?.isKind(of: UIViewController.self) == true {
                return next as? UIViewController
            }
            next = next?.next
        }
        return nil
    }
    
    /// View的safeAreaInsets
    var safeAreaInsets: UIEdgeInsets {
        guard #available(iOS 11.0, *) else { return UIEdgeInsets.zero }
        return jwWrappedValue.safeAreaInsets
    }
    
    /// 添加视图到父视图
    @discardableResult func adhere(toSuperView: UIView) -> T {
        toSuperView.addSubview(jwWrappedValue)
        return jwWrappedValue
    }
    
    /// 截图
    func screenShot() -> UIImage? {
        
        guard jwWrappedValue.frame.size.height > 0 && jwWrappedValue.frame.size.width > 0 else { return nil }
        
        UIGraphicsBeginImageContextWithOptions(jwWrappedValue.frame.size, false, 0)
        jwWrappedValue.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 配置蒙层
    func configMaskImg(image: UIImage?, maskColor: UIColor? = nil) {
        jwWrappedValue.configMaskImg(image: image, maskColor: maskColor)
    }
    
    /// 蒙层
    var circularMaskImgV: UIImageView? {
        return jwWrappedValue.circularMaskImgV
    }
    
}

@IBDesignable public extension UIView {
   
    /// 圆角
    @IBInspectable dynamic var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            if self.layer.masksToBounds != true {
                self.layer.masksToBounds = true
            }
        }
    }
    
    /// 边缘宽度
    @IBInspectable dynamic var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
            if self.layer.masksToBounds != true {
                self.layer.masksToBounds = true
            }
        }
    }
    
    /// 边缘颜色
    @IBInspectable dynamic var borderColor: UIColor? {
        get {
            guard let cgColor = self.layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
            if self.layer.masksToBounds != true {
                self.layer.masksToBounds = true
            }
        }
    }
    
    /// 配置蒙层
    fileprivate func configMaskImg(image: UIImage?, maskColor: UIColor? = nil) {

        guard let image = image else {
            if let imageView = self.circularMaskImgV, imageView.superview != nil {
                    imageView.removeFromSuperview()
            }
            return
        }

        if self.circularMaskImgV == nil {
            self.circularMaskImgV = UIImageView(frame: self.bounds)
            self.circularMaskImgV!.backgroundColor = UIColor.clear
            self.addSubview(self.circularMaskImgV!)
            self.circularMaskImgV!.translatesAutoresizingMaskIntoConstraints = false
            let layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .bottom, .trailing]
            layoutAttributes.forEach { attribute in
                self.addConstraint(NSLayoutConstraint(item: self.circularMaskImgV!,
                                                      attribute: attribute,
                                                      relatedBy: .equal,
                                                      toItem: self,
                                                      attribute: attribute,
                                                      multiplier: 1,
                                                      constant: 0.0))
            }
            
        }
        
        if maskColor != nil {
            self.circularMaskImgV?.image = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
             self.circularMaskImgV?.tintColor = maskColor!
        } else {
            self.circularMaskImgV?.image = image
            if self.circularMaskImgV?.tintColor != nil {
                self.circularMaskImgV?.tintColor = nil
            }
        }
    }
    
}

// 当使用setter方法时，对象本身必须是使用var声明的，即是变量
public extension JWNamespaceWrapper where T: UIView {
    
    var origin: CGPoint {
        get {
            return jwWrappedValue.frame.origin
        }
        
        set {
            var frame = jwWrappedValue.frame
            frame.origin = newValue
            jwWrappedValue.frame = frame
        }
    }
    
    var x: CGFloat {
        
        get {
            return jwWrappedValue.frame.origin.x
        }
        
        set {
            jwWrappedValue.frame.origin.x = newValue
        }
        
    }
    
    var y: CGFloat {
        
        get {
            return jwWrappedValue.frame.origin.y
        }
        
        set {
            jwWrappedValue.frame.origin.y = newValue
        }
    }
    
    var width: CGFloat {
        
        get {
            return jwWrappedValue.frame.size.width
        }
        
        set {
            jwWrappedValue.frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        
        get {
            return jwWrappedValue.frame.size.height
        }
        
        set {
            jwWrappedValue.frame.size.height = newValue
        }
        
    }
    
    var size: CGSize {
        get {
            return jwWrappedValue.frame.size
        }
        set {
            jwWrappedValue.frame.size = newValue
        }
    }
    
    var centerX: CGFloat {
        get {
            return jwWrappedValue.center.x
        }
        set {
            jwWrappedValue.center.x = newValue
        }
    }
    
    var centerY: CGFloat {
        get {
            return jwWrappedValue.center.y
        }
        set {
            var center = jwWrappedValue.center
            center.y = newValue
            jwWrappedValue.center = center
        }
    }
    
    var top: CGFloat {
        get {
            return jwWrappedValue.frame.origin.y
        }
        set {
            var frame = jwWrappedValue.frame
            frame.origin.y = newValue
            jwWrappedValue.frame = frame
        }
    }
    
    var bottom: CGFloat {
        get {
            return jwWrappedValue.frame.origin.y + jwWrappedValue.frame.size.height
        }
        set {
            var frame = jwWrappedValue.frame
            frame.origin.y = newValue - jwWrappedValue.frame.size.height
            jwWrappedValue.frame = frame
        }
    }
    
    var left: CGFloat {
        get {
            return jwWrappedValue.frame.origin.x
        }
        set {
            var frame = jwWrappedValue.frame
            frame.origin.x = newValue
            jwWrappedValue.frame = frame
        }
    }
    
    var right: CGFloat {
        get {
            return jwWrappedValue.frame.origin.x + jwWrappedValue.frame.size.width
        }
        set {
            var frame = jwWrappedValue.frame
            frame.origin.x = newValue - jwWrappedValue.frame.size.width
            jwWrappedValue.frame = frame
        }
    }
    
}

fileprivate extension UIView {
    struct UIViewRTKeys {
        static var hasCircularMaskImgV = "com.jw.app.hasCircularMaskImgV"
        static var circularMaskImgV = "com.jw.app.circularMaskImgV"
    }
    
    /// 蒙层
    var circularMaskImgV: UIImageView? {
        
        get {
            let view = objc_getAssociatedObject(self, &UIViewRTKeys.circularMaskImgV) as? UIImageView
            return view
        }
        set {
            objc_setAssociatedObject(self, &UIViewRTKeys.circularMaskImgV, newValue as UIImageView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /// 是否有蒙层
    var _hasCircularMaskImgV: Bool {
        get {
            return objc_getAssociatedObject(self, &UIViewRTKeys.hasCircularMaskImgV) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &UIViewRTKeys.hasCircularMaskImgV, newValue as Bool?, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN
            )
        }
    }
    
}

//
//  UIImage+MD.swift
//  MDAlarmClockApp
//
//  Created by xiaobin liu on 2017/9/22.
//  Copyright © 2017年 Linjw. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

/// 拓展UIImage
public extension JWNamespaceWrapper where T: UIImage {
    
    /// 模板图
    var imageTemplate: UIImage { return jwWrappedValue.withRenderingMode(.alwaysTemplate) }
    
    /// 原图
    var imageOriginal: UIImage { return jwWrappedValue.withRenderingMode(.alwaysOriginal) }
    
    /// 数据大小
    var bytesSize: Int { return jwWrappedValue.jpegData(compressionQuality: 1)?.count ?? 0 }
    
    /// 压缩比
    func ratioValue(compressionBytesSize: Int) -> CGFloat {
        let oriSize = self.bytesSize
        if oriSize > 0, oriSize > compressionBytesSize {
            return CGFloat(compressionBytesSize) / CGFloat(oriSize)
        }
        return 1
    }
    
    /// 九宫格拉伸
    var resizable: UIImage {
        let widthFloat = floor(jwWrappedValue.size.width / 2)
        let heightFloat = floor(jwWrappedValue.size.height / 2)
        return jwWrappedValue.resizableImage(withCapInsets: UIEdgeInsets(top: heightFloat, left: widthFloat, bottom: heightFloat, right: widthFloat))
    }
    
    /// Base64 String
    var base64: String { return jwWrappedValue.jpegData(compressionQuality: 1)?.base64EncodedString() ?? "" }
    
    /// 更改图片颜色
    func image(tintColor color: UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(jwWrappedValue.size, false, jwWrappedValue.scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return jwWrappedValue }
        
        context.translateBy(x: 0, y: jwWrappedValue.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: jwWrappedValue.size.width, height: jwWrappedValue.size.height)
        guard let mask = jwWrappedValue.cgImage else { return jwWrappedValue }
        context.clip(to: rect, mask: mask)
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
        
    }
    
    /// 填充透明区域颜色
    func image(fillColor: UIColor) -> UIImage { return jwWrappedValue.image(fillColor: fillColor) }
    
    /// 通过颜色，生成图片
    static func image(fromColor color: UIColor, size: CGSize = CGSize(width: 1, height: 1), cornerRadius: CGFloat = 0) -> UIImage {
        
        let width = max(size.width, CGFloat(cornerRadius * 2 + 1))
        let height = max(size.height, CGFloat(cornerRadius * 2 + 1))
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: CGFloat(cornerRadius))
        roundedRect.lineWidth = 0
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        color.setFill()
        roundedRect.fill()
        roundedRect.stroke()
        roundedRect.addClip()
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image.resizableImage(withCapInsets: UIEdgeInsets(top: CGFloat(cornerRadius), left: CGFloat(cornerRadius), bottom: CGFloat(cornerRadius), right: CGFloat(cornerRadius)))
    }
    
    func image(scale size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        jwWrappedValue.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
        
    }
    
}

// MARK: - 扩展
public extension UIImage {
    
    enum GradientDirection {
        case leftToRight
        case topToBottom
        case topLeftToBottomRight
        case botomLeftToTopRight
        case custom(CGPoint, CGPoint)
    }
    
    /// 生成颜色渐变图
    static func gradientImage(from starColor: UIColor, to endColor: UIColor, direction: UIImage.GradientDirection = .leftToRight, size: CGSize = CGSize(width: 200, height: 200)) -> UIImage {
        defer {
            UIGraphicsEndImageContext()
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [starColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0, 1]
        switch direction {
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        case .topLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        case .botomLeftToTopRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        case let .custom(startPoint, endPoint):
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
        }
        gradientLayer.frame = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let contenxt = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        gradientLayer.render(in: contenxt)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        return image
    }
    
    /// 截图
    class func screenshot(fromView fv: UIView) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(fv.bounds.size, fv.isOpaque, 0.0)
        fv.drawHierarchy(in: fv.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img ?? UIImage()
    }
    
    var compleHandle: ((Bool) -> Void)? {
        set {
            let key: UnsafeRawPointer! = UnsafeRawPointer(bitPattern: "com.jw.UIImage.compleHandle".hashValue)
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            let key: UnsafeRawPointer! = UnsafeRawPointer(bitPattern: "com.jw.UIImage.compleHandle".hashValue)
            let obj: ((Bool) -> Void)? = objc_getAssociatedObject(self, key) as! ((Bool) -> Void)?
            return obj
        }
    }
    
    /// 保存图片到相册
    func saveImageToAlbum(comple: ((Bool) -> Void)?) {
        
        UIImageWriteToSavedPhotosAlbum(self, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
        
        self.compleHandle = comple
    }
    
    @objc fileprivate func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        
        self.compleHandle?(error != nil)
        
    }
    
    fileprivate func image(fillColor: UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        
        fillColor.setFill()
        
        context.fill(rect)
        context.setBlendMode(.copy)
        self.draw(in: rect)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }
    
}

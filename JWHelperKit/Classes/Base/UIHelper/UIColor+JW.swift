//
//  UIColor.swift
//  MDAlarmClockApp
//
//  Created by Linjw on 2017/9/15.
//  Copyright © 2017年 Linjw. All rights reserved.
//

import UIKit

protocol UIColorSource {
    
    var rgbValue: UInt32 { get }
    
}

extension UInt32: UIColorSource {
    
    var rgbValue: UInt32 { return self }
}

public extension JWNamespaceWrapper where T: UIColor {
    
    /// 生成UIColor 例: UIColor(rgb: 0x000000)
    static func color(rgb rbgValue: UInt32, alpha: Float = 1.0) -> UIColor {
        return UIColor(rgb: rbgValue, alpha: alpha)
    }
    
    /// 生成UIColor
    static func color(r: Int, g: Int, b: Int, alpha: Float = 1.0) -> UIColor {
        return UIColor(r: r, g: g, b: b, alpha: alpha)
    }
    
    /// 生成UIColor 例: UIColor(hexString: "000000")
    static func color(hexString: String, alpha: Float = 1.0) -> UIColor {
        return UIColor(hexString: hexString, alpha: alpha)
    }
    
    /// 分割线颜色 224,224,224
    static var separatorColor: UIColor { return UIColor(rgb: 0xDEDFE0, alpha: 1) }
    
    /// 视图背景色 240,240,240
    static var viewBackgroundColor: UIColor { return UIColor(rgb: 0xF0F0F0, alpha: 1) }
    
    /// 白色线
    static var lineWhithColor: UIColor { return  UIColor(rgb: 0xDEDFE0, alpha: 1) }
    
    /// 灰色线
    static var lineGrayColor: UIColor { return UIColor(rgb: 0xD9D9D9, alpha: 1) }
    
}

extension UIColor {
    
    /// 生成UIColor 例: UIColor(rgb: 0x000000)
    fileprivate convenience init(rgb rgbValue: UInt32, alpha: Float = 1.0) {
        self.init(red: CGFloat(Float((rgbValue & 0xFF0000) >> 16) / 255.0),
                  green: CGFloat(Float((rgbValue & 0xFF00) >> 8) / 255.0),
                  blue: CGFloat(Float(rgbValue & 0xFF) / 255.0),
                  alpha: CGFloat(alpha))
    }
    
    /// 生成UIColor
    fileprivate convenience init(r: Int, g: Int, b: Int, alpha: Float = 1.0) {
        self.init(red: CGFloat(Float(r) / 255.0),
                  green: CGFloat(Float(g) / 255.0),
                  blue: CGFloat(Float(b) / 255.0),
                  alpha: CGFloat(alpha))
    }
    
    /// 生成UIColor
    fileprivate convenience init(hexString: String, alpha: Float = 1.0) {

        var toString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if toString.hasPrefix("#") {
            toString = toString.jw.string(from: 1)
        }
        
        if toString.hasPrefix("0X") {
            toString = toString.jw.string(from: 2)
        }
        
        let scanner = Scanner(string: toString)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff,
            alpha: CGFloat(alpha))
    }
    
}

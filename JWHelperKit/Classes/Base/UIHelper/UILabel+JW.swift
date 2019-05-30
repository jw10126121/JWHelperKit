//
//  UILabel+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2018/8/16.
//  Copyright © 2018年 Linjw. All rights reserved.
//

import UIKit

@IBDesignable public extension UILabel {
    
    /// (最大宽度 = 屏幕宽度 - maxLayoutToScreenWidth)
    @IBInspectable dynamic var maxLayoutToScreenWidth: CGFloat {
        get {
            return UIDevice.jw.screenWidth - self.preferredMaxLayoutWidth
        }
        
        set {
            self.preferredMaxLayoutWidth = UIDevice.jw.screenWidth - newValue
        }
    }
    
    /// 是否preferredMaxLayoutWidth根据屏幕宽度自动缩放
    @IBInspectable dynamic var fixMaxLayout: Bool {
        
        get {
            return _isAutoFixMaxLayout
        }
        set {
            
            if newValue && !_isAutoFixMaxLayout {
                // 要修复，并且没修复过
                
                // 标识已经修复过
                _isAutoFixMaxLayout = true
                
                self.preferredMaxLayoutWidth = self.preferredMaxLayoutWidth * UIDevice.jw.screenWidthScale
                
            } else if !newValue && _isAutoFixMaxLayout {
                
                // 标识未修复
                _isAutoFixMaxLayout = false
                
                self.preferredMaxLayoutWidth = self.preferredMaxLayoutWidth / UIDevice.jw.screenWidthScale

            }
            
        }
        
    }
    
    /// 字体根据屏幕宽度自动缩放
    @IBInspectable dynamic var fixFont: Bool {
        
        get {
            return _isAutoFixFontScale
        }
        set {
            
            if newValue && !_isAutoFixFontScale {
                // 要修复，并且没修复过

                // 标识已经修复过
                _isAutoFixFontScale = true
                
                // 设置字体修复
                if let theFont = self.font {
                    let currentSize = theFont.pointSize
                    let toSize = currentSize * UIDevice.jw.screenWidthScale
                    self.font = theFont.withSize(toSize)
                }
                
            } else if !newValue && _isAutoFixFontScale {
                
                // 标识未修复
                _isAutoFixFontScale = false
                
                // 把字体还原
                if let theFont = self.font {
                    let currentSize = theFont.pointSize
                    let toSize = currentSize / UIDevice.jw.screenWidthScale
                    self.font = theFont.withSize(toSize)
                }
            }
            
        }
        
    }
    
    /// 修复LineHeight
    static func fixLineHeightAttributed(_ lineHeight: CGFloat, font: UIFont) -> [NSAttributedString.Key: Any] {
        
        let paragrapStyle = NSMutableParagraphStyle()
        
        paragrapStyle.maximumLineHeight = lineHeight
        paragrapStyle.minimumLineHeight = lineHeight
        paragrapStyle.lineBreakMode = .byTruncatingTail
        
        let baselineOffset = fixBaseline(lineHeight: lineHeight, font: font)
        
        return [.paragraphStyle: paragrapStyle,
                .baselineOffset: baselineOffset,
                .font: font]

    }
    
    /// 根据行高和字体，生成基线值
    static func fixBaseline(lineHeight: CGFloat, font: UIFont) -> CGFloat {
        let baselineOffset = (lineHeight - font.lineHeight) / 4.0
        return baselineOffset
    }
    
}

// UILabel.Runtime
private extension UILabel {
    
    private struct UILabelRTKeys {
        static var KeyForAutoFixFontScale = "KeyForAutoFixFontScale"
        static var KeyForAutoFixMaxLength = "KeyForAutoFixMaxLength"
    }
    
    private var _isAutoFixFontScale: Bool {
        get {
            return objc_getAssociatedObject(self, &UILabelRTKeys.KeyForAutoFixFontScale) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &UILabelRTKeys.KeyForAutoFixFontScale, newValue as Bool?, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN
            )
        }
    }
    
    private var _isAutoFixMaxLayout: Bool {
        get {
            return objc_getAssociatedObject(self, &UILabelRTKeys.KeyForAutoFixMaxLength) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &UILabelRTKeys.KeyForAutoFixMaxLength, newValue as Bool?, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN
            )
        }
    }
    
}

public extension JWNamespaceWrapper where T: UILabel {
    
    /// 真实行间距 = 设计行间距 - 行间距偏移量(lineSpaceOffset)
    var lineSpaceOffset: CGFloat {
        return (jwWrappedValue.font.lineHeight - jwWrappedValue.font.pointSize)
    }
    
    /// (最大宽度 = 屏幕宽度 - maxLayoutToScreenWidth)
    var maxLayoutToScreenWidth: CGFloat {
        get {
            return UIDevice.jw.screenWidth - jwWrappedValue.preferredMaxLayoutWidth
        }
        
        set {
            jwWrappedValue.preferredMaxLayoutWidth = UIDevice.jw.screenWidth - newValue
        }
    }
    
    /// 带动画设置text
    func set(text aText: String?, duration: TimeInterval) {
        
        UIView.transition(with: jwWrappedValue, duration: duration, options: .transitionCrossDissolve, animations: { () -> Void in
            self.jwWrappedValue.text = aText
        }, completion: nil)
        
    }
    
}

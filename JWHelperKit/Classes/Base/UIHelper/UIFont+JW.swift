//
//  UIFont+JW+Rx.swift
//  AiXiaoYaApp
//
//  Created by Linjw on 2018/8/11.
//  Copyright © 2018年 Linjw. All rights reserved.
//

import Foundation
import UIKit

extension JWNamespaceWrapper where T == UIFont {

    /// 根据像素生成字体
    static func systemFont(ofPx px: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: px.jw.pxToFontSize)
    }

    /// 真实行间距 = 设计行间距 - 行间距偏移量(lineSpaceOffset)
    var lineSpaceOffset: CGFloat {
        return (jwWrappedValue.lineHeight - jwWrappedValue.pointSize)
    }
    
    
    
    
}


































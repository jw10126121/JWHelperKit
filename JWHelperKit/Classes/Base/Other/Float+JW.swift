//
//  FLoat+JW.swift
//  AiXiaoYaApp
//
//  Created by Linjw on 2018/8/11.
//  Copyright © 2018年 Linjw. All rights reserved.
//

import UIKit

extension JWNamespaceWrapper where T == CGFloat {
    
    /// px转成字体大小
    var pxToFontSize: CGFloat { return CGFloat(jwWrappedValue.pxToFontSize) }
}


fileprivate extension CGFloat {
    var pxToFontSize: CGFloat { return (self/96.0)*72.0 }
}


//extension JWNamespaceWrapper where T == Float {
//
//    var rmb: String? { return NSNumber(value: Float(jwWrappedValue)).jw.rmb }
//
//}

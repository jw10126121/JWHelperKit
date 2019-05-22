//
//  BinaryFloatingPoint+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2019/4/25.
//  Copyright © 2019 Linjw. All rights reserved.
//

import UIKit

/// 浮点型 (BinaryFloatingPoint: Float, Double, Float80, CGFloat)
extension JWNamespaceWrapper where T: BinaryFloatingPoint {
    
    /// 根据屏幕宽度比例缩放
    var scaleValueForScreenWidthRatio: T { return T(ceil(jwWrappedValue * T(UIDevice.jw.screenWidthScale))) }
    
    var rmb: String? { return NSNumber(value: Float(jwWrappedValue)).jw.rmb }
    
}



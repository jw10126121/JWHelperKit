//
//  BinaryFloatingPoint+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2019/4/25.
//  Copyright © 2019 Linjw. All rights reserved.
//

import UIKit

/// 浮点型 (BinaryFloatingPoint: Float, Double, Float80, CGFloat)
public extension JWNamespaceWrapper where T: BinaryFloatingPoint {
    
    /// 根据屏幕宽度比例缩放
    var scaleValueForScreenWidthRatio: T {
        return T(ceil(jwWrappedValue * T(UIDevice.jw.screenWidthScale)))
    }
    
    /// 人民币字符，最多2位小数，最少0位小数，比如1.99，1.9，1
    var rmb: String? { return NSNumber(value: Float(jwWrappedValue)).jw.rmb }
    
}

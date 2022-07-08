//
//  Int+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2019/3/8.
//  Copyright © 2019 Linjw. All rights reserved.
//

import Foundation
import UIKit

/// Int拓展
public extension JWNamespaceWrapper where T == Int {
    
    /// 转成Bool值
    var boolValue: Bool { return jwWrappedValue == 0 }

    /// 0..<self范围
    var range: CountableRange<Int> { return 0..<jwWrappedValue }
    
    /// 人民币字符串
    var rmb: String? { return CGFloat(jwWrappedValue).jw.rmb }
    
    /// 数字转字符串
    func digitsText(style: NumberFormatter.Style = .decimal, minDecimal: Int, maxDecimal: Int) -> String? {
        return NSNumber(value: jwWrappedValue).jw.digitsText(style: style, minDecimal: minDecimal, maxDecimal: maxDecimal)
    }
    
}

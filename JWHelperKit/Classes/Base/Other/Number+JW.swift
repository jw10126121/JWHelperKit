//
//  Number+JW.swift
//  TW
//
//  Created by linjw on 2018/10/30.
//  Copyright © 2018 Sky. All rights reserved.
//

import Foundation

// MARK: - NSNumber 扩展
public extension JWNamespaceWrapper where T: NSNumber {
    
    /// 最多2位小数，最少0位小数，比如1.99，1.9，1
    var rmb: String? { return self.rmb() }
    func rmb(minDecimal: Int = 0, maxDecimal: Int = 2) -> String? {
        return digitsText(style: .decimal, minDecimal: minDecimal, maxDecimal: maxDecimal)
    }
    
    /// 带最多2位小数的数字字符串
    var digits: String? { return digitsText(style: .decimal, minDecimal: 0, maxDecimal: 2) }
    
    func digitsText(style: NumberFormatter.Style = .decimal, minDecimal: Int, maxDecimal: Int) -> String? {
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = max(minDecimal, 0)
        formatter.maximumFractionDigits = max(maxDecimal, 0)
        formatter.numberStyle = style
        formatter.groupingSeparator = "" // 分组显示，默认是","号，千分位

        return formatter.string(from: jwWrappedValue)
    }
    
    /// 取小数
    func decimal(minDecimal: Int, maxDecimal: Int) -> String? {
        return digitsText(style: .decimal, minDecimal: minDecimal, maxDecimal: maxDecimal)
    }
    
}


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
    var rmb: String? {
        return rmb(style: .decimal)
    }
    
    func rmb(style: NumberFormatter.Style = .decimal) -> String? {
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = style
        
        return formatter.string(from: jwWrappedValue)
        
    }
    
}



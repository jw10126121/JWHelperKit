//
//  Date+JW.swift
//  AiXiaoYaApp
//
//  Created by Linjw on 2018/7/4.
//  Copyright © 2018年 Linjw. All rights reserved.
//

import Foundation

/// 格式化枚举
public enum TimeFormatterType {
    case HHmm // = "HH:mm"
    case mmss // = "mm:ss"
    case custom(String)
    
    /// 格式化字符串
    var formatterString: String {
        switch self {
        case .HHmm:
            return "HH:mm"
        case .mmss:
            return "mm:ss"
        case let .custom(formatter):
            return formatter
        }
    }
    
}

public extension JWNamespaceWrapper where T == Date {
    
    func toFormattedString(_ formatterType: TimeFormatterType) -> String {
        
        let df = DateFormatter()
        df.dateFormat = formatterType.formatterString
        
        return df.string(from: jwWrappedValue)
        
    }
    
}

public extension JWNamespaceWrapper where T == TimeInterval {
    
    /// 播放时间
    func toPlayTimeStr() -> String {
        
        let secounds = jwWrappedValue
        
        if secounds.isNaN {
            return "00:00"
        }
        var minute = Int(secounds / 60)
        let second = Int(secounds.truncatingRemainder(dividingBy: 60))
        var hour = 0
        if minute >= 60 {
            hour = Int(minute / 60)
            minute = minute - hour * 60
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        return String(format: "%02d:%02d", minute, second)
    }
    
}

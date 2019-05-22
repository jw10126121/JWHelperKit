//
//  Dictionary+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2018/8/23.
//  Copyright © 2018年 Linjw. All rights reserved.
//

import Foundation

/// Dictionary拓展
public extension JWNamespaceWrapper where T == [String: String] {
    
    mutating func mergeDifferent(params: T) {
        jwWrappedValue.merge(params) { (v, _) in v }
    }
    
    mutating func mergeUpdate(params: T) {
        jwWrappedValue.merge(params) { (_, v) in v }
    }
    
}

/// Dictionary拓展
extension Dictionary where Key == String, Value == String {
    
    /// Dictionary合并
    mutating func mergeDifferent(params: [Key: Value]) {
        self.merge(params) { (v, _) in v }
    }
    
    mutating func mergeUpdate(params: [Key: Value]) {
        self.merge(params) { (_, v) in v }
    }
    
    
    
}

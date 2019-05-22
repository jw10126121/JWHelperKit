//
//  Bool+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2019/3/8.
//  Copyright © 2019 Linjw. All rights reserved.
//

import Foundation

public extension JWNamespaceWrapper where T == Bool {

    // 转成Int类型
    var toInt: Int { return jwWrappedValue ? 1 : 0 }
    
    // 反转值
    var reversedValue: Bool { return !jwWrappedValue }
    
    
    
    
}

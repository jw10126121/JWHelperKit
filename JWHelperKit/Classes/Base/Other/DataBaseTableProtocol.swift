//
//  DataBaseTableProtocol.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2018/9/25.
//  Copyright © 2018 Linjw. All rights reserved.
//

import Foundation

// 数据库表
public protocol DataBaseTableProtocol {
    
    // 数据库表名
    static func dbTableName() -> String
    
}


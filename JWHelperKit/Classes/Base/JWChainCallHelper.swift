//
//  JWChainCall.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2019/4/29.
//  Copyright © 2019 Linjw. All rights reserved.
//

import UIKit

/// 链式调用拓展
public extension JWNamespaceWrapper where T: AnyObject {
    
    /// 配置
    @discardableResult func config(_ config: (T) -> Void) -> T {
        config(jwWrappedValue)
        return jwWrappedValue
    }
    
    /// 配置
    @discardableResult func this(_ config: (T) -> Void) -> T {
        config(jwWrappedValue)
        return jwWrappedValue
    }

    /// 配置
    @discardableResult func then(_ config: (T) -> Void) -> T {
        config(jwWrappedValue)
        return jwWrappedValue
    }
    
}


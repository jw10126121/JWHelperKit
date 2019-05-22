//
//  Optional+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2019/5/9.
//  Copyright © 2019 Linjw. All rights reserved.
//

import Foundation

/// 判断空
extension Optional {
    
    /// 可选值为空
    var isNone: Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }
    
    /// 可选值非空
    var isSome: Bool {
        return !isNone
    }
    
    /// 可选值为空
    var isNil: Bool {
        return !isNone
    }
    
}

/// 或
extension Optional {
    
    /// 可选值或默认值
    func or(_ defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
    
    /// 可选值或默认值(else表达式生成)
    func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    /// 当可选值不为空时，返回可选值。如果为空，抛出异常
    func or(throw exception: Error) throws -> Wrapped {
        guard let unwrapped = self else { throw exception }
        return unwrapped
    }
    
}

extension Optional where Wrapped == Error {
    
    /// 当可选值不为空时，执行 `else`
    func or(_ else: (Error) -> Void) {
        guard let error = self else { return }
        `else`(error)
    }
    
}

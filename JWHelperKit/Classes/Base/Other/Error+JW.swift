//
//  Error+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2019/3/7.
//  Copyright © 2019 Linjw. All rights reserved.
//

import UIKit

/// 错误信息协议
public protocol ErrorMessageProtocol {
    /// Error信息
    var errorMessage: String { get }

}

/// 拓展错误描述信息
public extension Error {

    /// Error信息 默认实现
    var errorMessage: String {
        guard let error = self as? ErrorMessageProtocol else {
            return self.localizedDescription
        }
        return error.errorMessage
    }
    
    /// 转化为NSError
    func asNSError() -> NSError {
        return NSError(domain: self._domain, code: self._code, userInfo: [NSLocalizedDescriptionKey: self.errorMessage])
    }

}

public extension JWNamespaceWrapper where T: Error {
    
    /// Error信息 默认实现
    var errorMessage: String {
        guard let error = jwWrappedValue as? ErrorMessageProtocol else {
            return jwWrappedValue.localizedDescription
        }
        return error.errorMessage
    }
    
}

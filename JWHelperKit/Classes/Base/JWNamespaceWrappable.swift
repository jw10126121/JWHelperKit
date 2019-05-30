//
//  NamespaceWrappable.swift
//
//
//  Created by LjwMac on 2018/1/15.
//  Copyright © 2018年 jw. All rights reserved.
//

// MARK: - 定义命名空间jw
import UIKit

extension NSObject: JWNamespaceWrappable {}
extension String: JWNamespaceWrappable {}

extension Bool: JWNamespaceWrappable {}

extension CGFloat: JWNamespaceWrappable {}
extension Float: JWNamespaceWrappable {}
extension Double: JWNamespaceWrappable {}

extension Int: JWNamespaceWrappable {}
extension Int8: JWNamespaceWrappable {}
extension Int16: JWNamespaceWrappable {}
extension Int32: JWNamespaceWrappable {}
extension Int64: JWNamespaceWrappable {}
extension UInt: JWNamespaceWrappable {}
extension UInt8: JWNamespaceWrappable {}
extension UInt16: JWNamespaceWrappable {}
extension UInt32: JWNamespaceWrappable {}
extension UInt64: JWNamespaceWrappable {}

extension CGPoint: JWNamespaceWrappable {}
extension CGSize: JWNamespaceWrappable {}
extension CGRect: JWNamespaceWrappable {}

/// 命名空间 (可对这个进行拓展，T为被拓展的类型)
public struct JWNamespaceWrapper<T> {
    public var jwWrappedValue: T
    public init(_ value: T) {
        self.jwWrappedValue = value
    }
}

/// 可封装成命名空间的类型
public protocol JWNamespaceWrappable {
    associatedtype JWWrapperType

    static var jw: JWNamespaceWrapper<JWWrapperType>.Type { get set }

    var jw: JWNamespaceWrapper<JWWrapperType> { get set }
}

/// 可封装成命名空间的类型默认实现
public extension JWNamespaceWrappable {
    static var jw: JWNamespaceWrapper<Self>.Type {
        get {
            return JWNamespaceWrapper<Self>.self
        }
        set {}
    }

    var jw: JWNamespaceWrapper<Self> {
        get {
            return JWNamespaceWrapper(self)
        }
        set {}
    }
}

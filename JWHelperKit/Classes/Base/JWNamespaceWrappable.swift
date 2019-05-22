//
//  NamespaceWrappable.swift
//
//
//  Created by LjwMac on 2018/1/15.
//  Copyright © 2018年 jw. All rights reserved.
//

// MARK: - 定义命名空间jw
import UIKit

public extension NSObject: JWNamespaceWrappable {}
public extension String:   JWNamespaceWrappable {}

public extension Bool:     JWNamespaceWrappable {}

public extension CGFloat:  JWNamespaceWrappable {}
public extension Float:    JWNamespaceWrappable {}
public extension Double:   JWNamespaceWrappable {}

public extension Int:      JWNamespaceWrappable {}
public extension Int8:     JWNamespaceWrappable {}
public extension Int16:    JWNamespaceWrappable {}
public extension Int32:    JWNamespaceWrappable {}
public extension Int64:    JWNamespaceWrappable {}
public extension UInt:     JWNamespaceWrappable {}
public extension UInt8:    JWNamespaceWrappable {}
public extension UInt16:   JWNamespaceWrappable {}
public extension UInt32:   JWNamespaceWrappable {}
public extension UInt64:   JWNamespaceWrappable {}

public extension CGPoint:  JWNamespaceWrappable {}
public extension CGSize:   JWNamespaceWrappable {}
public extension CGRect:   JWNamespaceWrappable {}

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

//
//  ResponseState.swift
//  ToMakeMoney
//
//  Created by LjwMac on 2018/1/15.
//  Copyright © 2018年 jw. All rights reserved.
//

import Foundation

/// 分页数据状态
public enum MultiplePageState {
    case ok
    case error(String)
}

/// MARK - 分页请求结果协议
public protocol MultiplePageable {
    
    /// 定义返回类型
    associatedtype MultiplePageableDataType
    
    /// 返回值
    var list: [MultiplePageableDataType] { get set }

    /// 返回状态
    var state: MultiplePageState { get set }
    
    /// 请求页码
    var page: Int { get set }
    
}

/// MARK - 分页数据状态
public struct ListDatasState<T>: MultiplePageable {
    
    public typealias MultiplePageableDataType = T
    
    public var list: [T]
    
    public var state: MultiplePageState
    
    public var page: Int = 0

}

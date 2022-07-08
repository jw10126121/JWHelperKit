//
//  UserDefaults+Codable.swift
//  WZStore
//
//  Created by xiaobin liu on 2019/7/6.
//  Copyright © 2019 我主良缘. All rights reserved.
//

import Foundation


/// MARK - UserDefaults仓库
public protocol UserDefaultsStorage {
    
    
    /// 保存对象到UserDefaults
    ///
    /// - Parameter defaultName: key(最好key最好以工程的BundleId+key，以避免冲突)
    /// - Returns: 保存是否成功
    @discardableResult
    func save(forKey defaultName: String) -> Bool
    
    
    /// 从UserDefaults获取对象
    ///
    /// - Parameter defaultName: key
    /// - Returns: 对象
    static func findObject(forKey defaultName: String) -> Codable?
    
    
    /// 移出
    ///
    /// - Parameter defaultName: key
    /// - Returns: 是否成功
    @discardableResult
    static func remove(forKey defaultName: String) -> Bool
}

// MARK: - Codable
extension UserDefaultsStorage where Self: Codable {
    
    @discardableResult
    public func save(forKey defaultName: String) -> Bool {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self),
            let stringJson = String(data: data, encoding: .utf8) else {
                return false
        }
        
        UserDefaults.standard.set(stringJson, forKey: defaultName)
        return UserDefaults.standard.synchronize()
    }
    
    public static func findObject(forKey defaultName: String) -> Codable? {
        
        guard let jsonString = UserDefaults.standard.object(forKey: defaultName) as? String,
            let jsonData = jsonString.data(using: .utf8),
            let result = try? JSONDecoder().decode(self, from: jsonData)
            else {
                return nil
        }
        return result
    }
    
    @discardableResult
    public static func remove(forKey defaultName: String) -> Bool {
        UserDefaults.standard.removeObject(forKey: defaultName)
        return UserDefaults.standard.synchronize()
    }
}

// MARK: - Array(为数组也添加保存以及获取的能力)
extension Array: UserDefaultsStorage where Element: Codable {
}

//
//  JWChooseImage.swift
//
//
//  Created by linjw on 2019/3/13.
//  Copyright © 2019 Linjw. All rights reserved.
//

import UIKit

/// 上传图片源（本地图片、网络图片）
public enum JWImageSource {
    
    /// 本地图片
    case localImage(UIImage?)
    /// 网络图片
    case networkImage(String?)
    
    /// 图片数据
    var imageData: JWImageSourceDataProtocol? {
        switch self {
        case let .localImage(image):     return image
        case let .networkImage(urlText):  return urlText
        }
    }
    
    var isNetworkImage: Bool {
        if case .networkImage(_) = self { return true }
        return false
    }
    
    var isLocalImage: Bool {
        if case .localImage(_) = self { return true }
        return false
    }
    
    var imageUrl: String? {
        if case let .networkImage(value) = self { return value }
        return nil
    }
    
    var image: UIImage? {
        if case let .localImage(value) = self { return value }
        return nil
    }
    
}

extension JWImageSource: Equatable { }

extension JWImageSource: CustomStringConvertible, CustomDebugStringConvertible {
    public var debugDescription: String {
        return self.description
    }
    
    public var description: String {
        switch self {
        case .localImage: return "本地图片"
        case let .networkImage(image): return "网络图片: \(image ?? "nil")"
        }
    }
    
}

public protocol JWImageSourceDataProtocol {
    var isLocalImage: Bool { get }
    var isNetworkImage: Bool { get }
}

extension String: JWImageSourceDataProtocol {
    public var isNetworkImage: Bool { return true }
    public var isLocalImage: Bool { return false }
}

extension UIImage: JWImageSourceDataProtocol {
    public var isNetworkImage: Bool { return false }
    public var isLocalImage: Bool { return true }
}


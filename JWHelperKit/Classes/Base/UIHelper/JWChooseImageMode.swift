//
//  JWChooseImage.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2019/3/13.
//  Copyright © 2019 Linjw. All rights reserved.
//

import UIKit

/// 选择图片模式
public enum JWChooseImageMode {
    
    /// 什么都不做
    case none
    /// 本地图片
    case image(UIImage?)
    /// URL
    case url(String?)
    
}

extension JWChooseImageMode: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .image:
            return "本地图片"
        case .url:
            return "网络图片"
        default:
            return ""
        }
    }
    
}

//
//  JWChooseImage.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2019/3/13.
//  Copyright © 2019 Linjw. All rights reserved.
//

import UIKit

/// 选择图片模式
enum JWChooseImageMode {
    
    /// 什么都不做
    case none
    /// 本地图片
    case image(UIImage?)
    /// URL
    case url(String?)
    
    
}

extension JWChooseImageMode: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .image(_):
            return "本地图片"
        case .url(_):
            return "网络图片"
        default:
            return ""
        }
    }
    
}

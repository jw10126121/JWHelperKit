//
//  JWChooseImageMode.swift
//  oa
//
//  Created by Linjw on 2022/3/18.
//

import Foundation
import UIKit


/// 选择后的图片类型
public enum JWChooseImageMode {
    
    /// app图片
    case appImage(UIImage?)
    /// 图片(本地图片或网络图片)
    case image(JWImageSource)
    
}


extension JWChooseImageMode: Equatable {}

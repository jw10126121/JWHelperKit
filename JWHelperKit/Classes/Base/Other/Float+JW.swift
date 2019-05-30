//
//  FLoat+JW.swift
//  AiXiaoYaApp
//
//  Created by Linjw on 2018/8/11.
//  Copyright © 2018年 Linjw. All rights reserved.
//

import UIKit

public extension JWNamespaceWrapper where T == CGFloat {
    
    /// px转成字体大小
    var pxToFontSize: CGFloat { return CGFloat(jwWrappedValue.pxToFontSize) }
}

fileprivate extension CGFloat {
    var pxToFontSize: CGFloat { return (self / 96.0) * 72.0 }
}

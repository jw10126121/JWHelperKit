//
//  UISwitch+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2019/3/8.
//  Copyright © 2019 Linjw. All rights reserved.
//

import UIKit

/// 拓展 UISwitch
public extension JWNamespaceWrapper where T: UISwitch {
    
    /// 值反转
    func reversed(animated: Bool = true) {
        jwWrappedValue.setOn(!jwWrappedValue.isOn, animated: animated)
    }
    
}


//
//  UIAlertController+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2019/5/22.
//  Copyright © 2019 Linjw. All rights reserved.
//

import UIKit


public extension JWNamespaceWrapper where T: UIAlertController {
    

    var messageLabel: UILabel? {
        
        return self.jwWrappedValue.view
            .subviews[0]
            .subviews[0]
            .subviews[0]
            .subviews[0]
            .subviews[0]
            .subviews[1] as? UILabel
        
    }
    
    
    
}

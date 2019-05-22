//
//  NSMutableAttributedString+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2018/8/16.
//  Copyright © 2018年 Linjw. All rights reserved.
//

import UIKit

public extension JWNamespaceWrapper where T == NSMutableAttributedString {
    

    
    func bold() -> NSMutableAttributedString {
        
        let range = (jwWrappedValue.string as NSString).range(of: jwWrappedValue.string)

        jwWrappedValue.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        
        return jwWrappedValue
    }
    
    func underline() -> NSMutableAttributedString {
        
        let range = (jwWrappedValue.string as NSString).range(of: jwWrappedValue.string)
        
        jwWrappedValue.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: range)
        
        return jwWrappedValue
    }
    
    
}



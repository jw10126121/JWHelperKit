//
//  UIViewController+JW.swift
//  AiXiaoYaApp
//
//  Created by Linjw on 2018/6/14.
//  Copyright © 2018年 Linjw. All rights reserved.
//

import UIKit

/// 拓展UIViewController
public extension JWNamespaceWrapper where T: UIViewController {
    
    /// 通过StoryBoard生成VC
    static func vcFromStoryBoard(sbName: String, id: String? = nil) -> T {
        
        let theId: String = id ?? "\(T.self)"
        
        let vc = UIStoryboard(name: sbName, bundle: nil).instantiateViewController(withIdentifier: theId)
        
        return vc as! T
    }
    
    /// 安全区域
    var safeAreaInsets: UIEdgeInsets {
        guard #available(iOS 11.0, *) else {
            return UIEdgeInsets.zero
        }
        return jwWrappedValue.view.safeAreaInsets
    }
    
    /// 设置ScrollView Insets 自动调整(iOS11以下，需要在ScrollView添加到viewController上才能用)
    func contentInsetAdjustmentBehaviorAutomatic(_ scrollView: UIScrollView?, auto: Bool = true) {
        scrollView?.jw.contentInsetAdjustmentBehaviorAutomatic(auto)
    }
    
}

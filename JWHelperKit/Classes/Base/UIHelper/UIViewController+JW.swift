//
//  UIViewController+JW.swift
//  AiXiaoYaApp
//
//  Created by Linjw on 2018/6/14.
//  Copyright © 2018年 Linjw. All rights reserved.
//

import Foundation
import UIKit

public enum BarButtonItemType {
    case left
    case right
}

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
        guard #available(iOS 11.0, *) else { return UIEdgeInsets.zero }
        return jwWrappedValue.view.safeAreaInsets
    }
    
    /// 设置ScrollView Insets 自动调整(iOS11以下，需要在ScrollView添加到viewController上才能用)
    func contentInsetAdjustmentBehaviorAutomatic(_ scrollView: UIScrollView?, auto: Bool = true) {
        scrollView?.jw.contentInsetAdjustmentBehaviorAutomatic(auto)
    }
    
//    /// 添加左边导航栏按钮
//    func leftBarButton(_ items: [UIBarButtonItem]) {
//        self.fixedBarButton(items, barButtonItemType: .left)
//    }
//
//    /// 添加右边导航栏按钮
//    func rightBarButton(_ items: [UIBarButtonItem]) {
//        self.fixedBarButton(items, barButtonItemType: .right)
//    }
//
//    /// 修复IOS7以上的偏移量
//    private func fixedBarButton(_ items: [UIBarButtonItem], barButtonItemType: BarButtonItemType) {
//
//        let buttonItemSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        buttonItemSpacer.width = -6
//
//        var barButtonItems = [UIBarButtonItem]()
//        for barButtonItem in items {
//
//            if #available(iOS 11.0, *) {
//                // do thing
//            } else {
//                barButtonItems.append(buttonItemSpacer)
//            }
//            barButtonItems.append(barButtonItem)
//        }
//
//        switch barButtonItemType {
//        case .left:
//            jwWrappedValue.navigationItem.leftBarButtonItems = barButtonItems
//        case .right:
//            jwWrappedValue.navigationItem.rightBarButtonItems = barButtonItems
//        }
//    }
}


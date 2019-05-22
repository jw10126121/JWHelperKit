//
//  UITableView+MD.swift
//  MDAlarmClockApp
//
//  Created by xiaobin liu on 2017/9/18.
//  Copyright © 2017年 Linjw. All rights reserved.
//

import UIKit



// MARK: - UITableView拓展
public extension JWNamespaceWrapper where T: UITableView {

    
    /// 默认配置
    @discardableResult func defaultStyles() -> T {
        
        jwWrappedValue.backgroundColor = .clear
        jwWrappedValue.separatorInset = .zero
        jwWrappedValue.separatorStyle = .none

        if #available(iOS 9, *) {
            jwWrappedValue.cellLayoutMarginsFollowReadableWidth = true
        }
        
        /// 设置ScrollView Insets 是否自动调整(iOS11以下，需要在ScrollView添加到viewController上才能用)
        jwWrappedValue.jw.contentInsetAdjustmentBehaviorAutomatic(false)
        
        hiddenExpandSeparatedLines()
        
        fixAutolayoutAutoRowHeight()

        return jwWrappedValue
    }
    
    /// 修复tableView行高问题
    @discardableResult func fixAutolayoutAutoRowHeight() -> T {
        
        jwWrappedValue.rowHeight = UITableView.automaticDimension
        
        if #available(iOS 11, *) {
            
        } else {
            jwWrappedValue.estimatedRowHeight = 44  //  这个很重要，至于为什么，我也不知道！！
        }
        return jwWrappedValue
    }
    
    /// 隐藏footer多余分隔线
    @discardableResult func hiddenExpandSeparatedLines() -> T {
        jwWrappedValue.tableFooterView = UIView()
        return jwWrappedValue
    }
    
    
    
    
}

// MARK: - UITableViewCell拓展
public extension JWNamespaceWrapper where T: UITableViewCell {
    
    /// 获取cell所在的UITableView
    func tableView() -> UITableView? {
        
        for view in sequence(first: jwWrappedValue.superview, next: { $0?.superview }) {
            if let tableView = view as? UITableView {
                return tableView
            }
        }
        return nil
        
    }
}

//
//  UITableView+MD.swift
//  MDAlarmClockApp
//
//  Created by xiaobin liu on 2017/9/18.
//  Copyright © 2017年 Linjw. All rights reserved.
//

import UIKit

@objc public extension UITableView {
    func wDefaultStyles() {
        self.jw.defaultStyles()
    }
}

// MARK: - UITableView拓展
public extension JWNamespaceWrapper where T: UITableView {
    
    /// 默认配置
    @discardableResult func defaultStyles() -> T {
        
//        jwWrappedValue.backgroundColor = .clear
        jwWrappedValue.separatorInset = .zero
        jwWrappedValue.separatorStyle = .none
        jwWrappedValue.separatorColor = nil
        
        jwWrappedValue.showsVerticalScrollIndicator = false
        jwWrappedValue.showsHorizontalScrollIndicator = false

        if #available(iOS 9, *) { jwWrappedValue.cellLayoutMarginsFollowReadableWidth = true }
        
        if #available(iOS 15.0, *) { jwWrappedValue.sectionHeaderTopPadding = 0 }
        
        /// 设置ScrollView Insets 是否自动调整(iOS11以下，需要在ScrollView添加到viewController上才能用)
        jwWrappedValue.jw.contentInsetAdjustmentBehaviorAutomatic(false)
        
        hiddenExpandSeparatedLines()
        
        fixAutolayoutAutoRowHeight()

        return jwWrappedValue
    }
    
    /// 修复tableView行高问题
    @discardableResult func fixAutolayoutAutoRowHeight() -> T {
        
        jwWrappedValue.rowHeight = UITableView.automaticDimension
        
        guard #available(iOS 11, *) else {
            jwWrappedValue.estimatedRowHeight = 44 //  iOS11以下，如果不设置这个，cell高度会错乱
            return jwWrappedValue
        }
        return jwWrappedValue
    }
    
    /// 隐藏footer多余分隔线
    @discardableResult func hiddenExpandSeparatedLines() -> T {
        jwWrappedValue.tableFooterView = UIView()
        return jwWrappedValue
    }
    
    /// 去掉头部黏性
    static func headStickyDisable(scrollView: UIScrollView, headHeight: Float) {
        
        var insets = scrollView.contentInset
        
        let sectionHeaderHeight = CGFloat(headHeight)
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
            insets.top = -scrollView.contentOffset.y
            scrollView.contentInset = insets
        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            insets.top = -sectionHeaderHeight
            scrollView.contentInset = insets
        }
    }
    
    /// 自定义分组类似于ipad的样式，tableView要设置成.plain样式
    static func group(tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath,
               cornerRadius: CGFloat = 10.0, // 圆角
               contentHorizontalInsetValue: CGFloat = 15,  // cell的contentView左右偏移
               contentViewBackgroundColor: UIColor = UIColor(white: 1, alpha: 0.8),
               hasSeparatorLine: Bool = true,   // 是否画分割线 (如果这边添加了分割线，tableView的分割线要设置为.none)
               separatorInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
               separatorColor: UIColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)) {
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        let layer = CAShapeLayer()
        let backgroundLayer = CAShapeLayer()
        let pathRef = CGMutablePath()
        let bounds = cell.bounds.insetBy(dx: contentHorizontalInsetValue, dy: 0)
        var addLine = false
        
        if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        } else if indexPath.row == 0 {
            pathRef.move(to: .init(x: bounds.minX, y: bounds.maxY))
            pathRef.addArc(tangent1End: .init(x: bounds.minX, y: bounds.minY), tangent2End: .init(x: bounds.midX, y: bounds.minY), radius: cornerRadius)
            pathRef.addArc(tangent1End: .init(x: bounds.maxX, y: bounds.minY), tangent2End: .init(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            pathRef.addLine(to: .init(x: bounds.maxX, y: bounds.maxY))
            addLine = true
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.move(to: .init(x: bounds.minX, y: bounds.minY))
            pathRef.addArc(tangent1End: .init(x: bounds.minX, y: bounds.maxY), tangent2End: .init(x: bounds.midX, y: bounds.maxY), radius: cornerRadius)
            pathRef.addArc(tangent1End: .init(x: bounds.maxX, y: bounds.maxY), tangent2End: .init(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            pathRef.addLine(to: .init(x: bounds.maxX, y: bounds.minY))
        } else {
            pathRef.addRect(bounds)
            addLine = true
        }
        
        layer.path = pathRef
        backgroundLayer.path = pathRef
        layer.fillColor = contentViewBackgroundColor.cgColor //UIColor(white: 1, alpha: 0.8).cgColor
        
        if (addLine == true && hasSeparatorLine) {
            let lineLayer = CALayer()
            let lineHeight = 1.0 / UIScreen.main.scale
            lineLayer.frame = CGRect(x: bounds.minX + separatorInset.left, y: bounds.size.height - lineHeight, width: bounds.size.width - separatorInset.left - separatorInset.right, height: lineHeight)
            lineLayer.backgroundColor = separatorColor.cgColor
            layer.addSublayer(lineLayer)
        }
        
        let backView = UIView(frame: bounds)
        backView.layer.insertSublayer(layer, at: 0)
        backView.backgroundColor = .clear
        cell.backgroundView = backView
        
        /// 设置点击背景色
        let selectedBackgroundView = UIView(frame: cell.bounds)
        backgroundLayer.fillColor = separatorColor.cgColor
        selectedBackgroundView.layer.insertSublayer(backgroundLayer, at: 0)
        selectedBackgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = selectedBackgroundView
        
    }
    
}

// MARK: - UITableViewCell拓展
public extension JWNamespaceWrapper where T: UITableViewCell {
    
    /// 获取cell所在的UITableView
    @discardableResult func tableView() -> UITableView? {
        
        for view in sequence(first: jwWrappedValue.superview, next: { $0?.superview }) {
            if let tableView = view as? UITableView {
                return tableView
            }
        }
        return nil
        
    }
}

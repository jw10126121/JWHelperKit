//
//  UICollectionViewFlowLayout+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2019/4/15.
//  Copyright © 2019 Linjw. All rights reserved.
//

import UIKit

// MARK: - UITableView拓展
public extension JWNamespaceWrapper where T: UICollectionViewFlowLayout {
    
    /// 默认配置
    func defaultStyles() {
        jwWrappedValue.minimumInteritemSpacing = 0
        jwWrappedValue.minimumLineSpacing = 0
    }
    
}

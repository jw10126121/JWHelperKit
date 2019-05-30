//
//  UICollectionView+JW.swift
//
//
//  Created by LjwMac on 2018/9/27.
//  Copyright © 2018 Linjw. All rights reserved.
//

import UIKit

// MARK: - 拓展UICollectionViewCell
public extension JWNamespaceWrapper where T: UICollectionReusableView {
    
    /// 获取cell所在的UICollectionView
    func collectionView() -> UICollectionView? {
        
        for view in sequence(first: jwWrappedValue.superview, next: { $0?.superview }) {
            if let tableView = view as? UICollectionView {
                return tableView
            }
        }
        return nil
        
    }
    
}

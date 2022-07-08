//
//  CollectionViewCell+Reusable.swift
//  saasApp
//
//  Created by ShuHua on 2022/6/22.
//

import UIKit
#if canImport(Reusable)
import Reusable
#endif

#if canImport(Reusable)
// MARK: - 扩展UICollectionViewCell默认继承Reusable协议
extension UICollectionViewCell: Reusable { }
#endif

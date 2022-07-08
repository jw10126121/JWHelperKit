//
//  UIViewController+EachNavigationBar.swift
//  shuhuaSport
//
//  Created by ShuHua on 2022/6/9.
//  Copyright © 2022 biubiubiu. All rights reserved.
//

import UIKit
#if canImport(EachNavigationBar)
import EachNavigationBar
#endif


@objc public extension UIViewController {
    
    @objc var navBar: UINavigationBar? {
        var navBar = navigationController?.navigationBar
#if canImport(EachNavigationBar)
        navBar = navigationController?.navigation.configuration.isEnabled == true ? navigation.bar : navigationController?.navigationBar
#else
        navBar = navigationController?.navigationBar
#endif
        return navBar
    }
    
    @objc var navItem: UINavigationItem {
        var navItem = navigationItem
#if canImport(EachNavigationBar)
        navItem = navigationController?.navigation.configuration.isEnabled == true ? navigation.item : navigationItem
#else
        navItem = navigationItem
#endif
        return navItem
    }
    
    /// 设置导航条
    @objc func configNavigationTitle(_ text: String?) {
        navItem.title = text
    }
    
    @objc func configNavigationBarHidden(_ hidden: Bool) {
        navBar?.isHidden = hidden
    }
    
    @objc func configNavigationBarBottomLineHidden(_ isHidden: Bool = true) {
        navBar?.shadowImage = isHidden ? UIImage() : nil
        if #available(iOS 13.0, *) {
            let newAppearance = UINavigationBarAppearance()
            let oriAppearance = navBar?.standardAppearance
            let appearance = oriAppearance ?? UINavigationBarAppearance()
            //            appearance.configureWithOpaqueBackground()
            if isHidden {
                appearance.shadowColor = UIColor.clear
            } else {
                appearance.shadowColor = newAppearance.shadowColor
            }
            appearance.shadowImage =  isHidden ? UIImage() : newAppearance.shadowImage
            navBar?.standardAppearance = appearance
            navBar?.scrollEdgeAppearance = appearance
        }
    }
    
    /// 设置导航条透明，这个属性，自带navigationBar在iOS13以下，如果不设置为true，导航条就不能透明
    @objc func configNavigationBarIsTranslucent(_ isTranslucent: Bool = false) {
        navBar?.isTranslucent = isTranslucent
    }
    
    @objc func configNavigationBarBackgroundColor(_ color: UIColor?, hideBottomLine: Bool = true) {
        let backgroundImage = UIImage.jw.image(fromColor: color ?? UIColor.clear, size: CGSize(width: UIDevice.jw.screenWidth, height: UIDevice.jw.navBarHeight))
        
        navBar?.backgroundColor = UIColor.clear
        navBar?.barTintColor = UIColor.clear
        navBar?.setBackgroundImage(backgroundImage, for: .any, barMetrics: .default)
        navBar?.shadowImage = hideBottomLine ? UIImage.jw.image(fromColor: .clear, size: CGSize(width: 1, height: 1)).jw.imageOriginal : nil
        
        if #available(iOS 13.0, *) {
            let newAppearance = UINavigationBarAppearance()
            let oriAppearance = navBar?.standardAppearance
            let appearance = oriAppearance ?? UINavigationBarAppearance()
            //            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.clear
            appearance.backgroundImage = backgroundImage
            appearance.shadowColor = hideBottomLine ? UIColor.clear : newAppearance.shadowColor
            appearance.shadowImage =  hideBottomLine ? UIImage.jw.image(fromColor: .clear, size: CGSize(width: 1, height: 1)).jw.imageOriginal : newAppearance.shadowImage
            navBar?.standardAppearance = appearance
            navBar?.scrollEdgeAppearance = navBar?.standardAppearance
        }
    }
    
    @objc func configNavigationTitleFont(_ font: UIFont) {
        
        var it = navBar?.titleTextAttributes ?? [:]
        it[NSAttributedString.Key.font] = font
        navBar?.titleTextAttributes = it
        
        if #available(iOS 13.0, *) {
            let oriAppearance = navBar?.standardAppearance
            let appearance = oriAppearance ?? UINavigationBarAppearance()
            appearance.titleTextAttributes = it
            navBar?.standardAppearance = appearance
            navBar?.scrollEdgeAppearance = appearance
        }
    }
    
    @objc func configNavigationTitleColor(_ color: UIColor?) {
        
        var it = navBar?.titleTextAttributes ?? [:]
        it[NSAttributedString.Key.foregroundColor] = color ?? UIColor.clear
        navBar?.titleTextAttributes = it
        
        if #available(iOS 13.0, *) {
            let appearance = navBar?.standardAppearance ?? UINavigationBarAppearance()
            //            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = it
            navBar?.standardAppearance = appearance
            navBar?.scrollEdgeAppearance = appearance
        }
        
    }
    
    @objc func configNavigationTitleView(_ titleView: UIView?) {
        navItem.titleView = titleView
    }
    
    @objc func configNavigationLeftBarButtonItem(_ barItem: UIBarButtonItem?) {
        navItem.leftBarButtonItem = barItem
    }
    
    @objc func configNavigationLeftBarButtonItems(_ barItems: [UIBarButtonItem]) {
        navItem.leftBarButtonItems = barItems
    }
    
    @objc func configNavigationRightBarButtonItem(_ barItem: UIBarButtonItem?) {
        navItem.rightBarButtonItem = barItem
    }
    
    @objc func configNavigationRightBarButtonItems(_ barItems: [UIBarButtonItem]) {
        navItem.rightBarButtonItems = barItems
    }
    
}

@objc extension UIViewController {
    

    
}


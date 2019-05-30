//
//  UIDevice+JW.swift
//  AiXiaoYaApp
//
//  Created by Linjw on 2018/7/13.
//  Copyright © 2018年 Linjw. All rights reserved.
//

import UIKit
import WebKit

public extension JWNamespaceWrapper where T: UIDevice {

    /// 是否 iPad
    static var isIPad: Bool { return UIDevice.isIPad }
    
    /// 是否 iPhone
    static var isIPhone: Bool { return UIDevice.isIPhone }
    
    /// 是否 模拟器
    static var isSimulator: Bool { return UIDevice.isSimulator }
    
    /// 系统版本号
    static var iosVersion: String { return UIDevice.iosVersionStr }

    /// app 版本号
    static var appVersion: String { return UIDevice.appVersionStr }
    
    /// app 编译号
    static var appBundleVersion: String { return UIDevice.appBundleStr }
    
    /// app 名
    static var appDisplayName: String { return UIDevice.appDisplayName }
    
    /// app BundleId
    static var appBundleId: String { return UIDevice.appBundleId }
    
    /// 是否 iPhoneX
    static var isIPhoneX: Bool { return UIDevice.isIPhoneX }
    
    /// 是否刘海屏
    static var isFringeScreen: Bool { return UIDevice.isFringeScreen }
    
    /// 屏幕亮度
    static var screenBrightness: Int { return UIDevice.screenBrightness }

    /// 屏幕位置
    static var screenCurrentBounds: CGRect { return UIDevice.screenCurrentBounds }
    
    /// 屏幕宽
    static var screenWidth: CGFloat { return UIDevice.screenWidth }
    
    /// 屏幕高
    static var screenHeight: CGFloat { return UIDevice.screenHeight }

    /// 横竖屏高度
    static var screenAutoHeight: CGFloat { return UIDevice.screenCurrentBounds.size.height }
    
    /// 横竖屏宽度
    static var screenAutoWidth: CGFloat { return UIDevice.screenCurrentBounds.size.width }
    
    ///  safeAreaInsets (必须在设置了keyWindow后，才能用)
    static var safeAreaInsets: UIEdgeInsets { return UIDevice.safeAreaInsets }
    
    ///  navigationBar高
    static var navBarHeight: CGFloat { return UIDevice.navBarHeight }

    /// tabbar 高
    static var tabBarHeight: CGFloat { return UIDevice.tabBarHeight }

    /// statusBar 高
    static var statusBarHeight: CGFloat { return UIDevice.statusBarHeight }

    /// 屏幕与 iPhone6 宽度比
    static var screenWidthScale: CGFloat { return UIDevice.screenWidthScale }

    /// 缓存目录
    static var cacheDir: String { return UIDevice.cacheDir }
    
    /// 临时文件目录
    static var tempDir: String { return UIDevice.tempDir }
    
    /// 文档目录
    static var documentDir: String { return UIDevice.documentDir }
    
    /// app icon 图片名
    static var appIconName: String? { return UIDevice.appIconName }
    
    // 是否横屏
    static var isLandscape: Bool { return UIApplication.shared.statusBarOrientation.isLandscape }
    
    /// 开关键盘 (必须在设置了keyWindow后，才能用)
    static func endEditing(_ force: Bool = true) { UIApplication.shared.keyWindow?.endEditing(force) }
    
    /// 删除文件
    @discardableResult
    static func removeFile(atPath: String?) -> Bool {
        if let atPath = atPath, FileManager.default.fileExists(atPath: atPath) {
            do {
                try FileManager.default.removeItem(atPath: atPath)
            } catch {
                return false
            }
            return true
        }
        return false
    }
    
    /// 跳转到设置
    static func toSystemPrivacySettingsView() {
        
        guard let appSetting = URL(string: UIApplication.openSettingsURLString) else { return }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appSetting, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(appSetting)
        }
        
    }
    
    static func transformRotationAngle(from io: UIInterfaceOrientation) -> CGAffineTransform {
        return UIDevice.transformRotationAngle(from: io)
    }
    
    static func interfaceOrientation(from deviceO: UIDeviceOrientation) -> UIInterfaceOrientation {
        return UIDevice.interfaceOrientation(from: deviceO)
    }

    static func orientation(to: UIInterfaceOrientation) {
        
        UIViewController.attemptRotationToDeviceOrientation()
        
        UIDevice.current.setValue(UIInterfaceOrientation.unknown.rawValue, forKey: "orientation")
        UIDevice.current.setValue(to.rawValue, forKey: "orientation")

    }
    
    /// 加载xib, 如：Bundle.loadNib("ViewXibName", owner: self); self.addSubview(self.contentView)
    static func loadNib(_ name: String, owner: AnyObject!) {
        _ = Bundle.main.loadNibNamed(name, owner: owner, options: nil)?[0]
    }
    
    /// 加载xib, 如：let view: ViewXibName = Bundle.loadNib("ViewXibName")
    static func loadNib<T>(_ name: String) -> T? {
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?[0] as? T
    }
    
    /// 延迟运行
    static func runThisAfterDelay(seconds: Double, queue: DispatchQueue, after: @escaping () -> Void) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: time, execute: after)
    }
    
    /// 在主线程中运行
    static func runThisInMainThread(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }
    
    /// 在默认优先队列中运行
    static func runThisInBackground(_ block: @escaping () -> Void) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
    
}

fileprivate extension UIDevice {
    
     static func transformRotationAngle(from io: UIInterfaceOrientation) -> CGAffineTransform {
        var t: CGAffineTransform = CGAffineTransform.identity
        if io == UIInterfaceOrientation.portrait {
            
        } else if io == UIInterfaceOrientation.landscapeLeft {
            t = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        } else if io == UIInterfaceOrientation.landscapeRight {
            t = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
        }
        return t
    }
    
    // 设备方向转化为屏幕方向
     static func interfaceOrientation(from deviceO: UIDeviceOrientation) -> UIInterfaceOrientation {
        
        switch deviceO {
        case .landscapeLeft:
            return .landscapeRight
        case .landscapeRight:
            return .landscapeLeft
        case .unknown:
            return .unknown
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
        default:
            return .portrait
            
        }
    }
    
     static let isIPad: Bool = (UIDevice.current.userInterfaceIdiom == .pad)
    
     static let isIPhone: Bool = (UIDevice.current.userInterfaceIdiom == .phone)
    
     static let isSimulator: Bool = {
        #if arch(i386) || arch(x86_64)
            return true
        #else
            return false
        #endif
    }()

     static var isIPhoneX: Bool {
        
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
            return false
        }
        
        if #available(iOS 11, *), UIApplication.shared.windows.first?.safeAreaInsets != UIEdgeInsets.zero {
            return true
        }
        
        return false
    }
    
     static let screenWidth: CGFloat = CGFloat(UIScreen.main.bounds.size.width)
    
     static let screenHeight: CGFloat = CGFloat(UIScreen.main.bounds.size.height)
    
     static let navBarHeight: CGFloat = CGFloat(UIApplication.shared.statusBarFrame.maxY) + 44

     static let tabBarHeight: CGFloat = 49 + UIDevice.safeAreaInsets.bottom

     static var statusBarHeight: CGFloat = CGFloat(UIApplication.shared.statusBarFrame.maxY)
    
     static let screenWidthScale: CGFloat = CGFloat(UIScreen.main.bounds.width / 375.0)

     static var screenCurrentBounds: CGRect {
        
        var rect = UIScreen.main.bounds
       
        if UIApplication.shared.statusBarOrientation.isLandscape {
            let buffer = rect.size.width
            rect.size.width = rect.size.height
            rect.size.height = buffer
        }
        return rect
        
    }

     static let safeAreaInsets: UIEdgeInsets = {
        
        let defaultInsets = UIEdgeInsets(top: CGFloat(UIApplication.shared.statusBarFrame.maxY), left: 0, bottom: 0, right: 0)
        
        guard #available(iOS 11.0, *) else { return defaultInsets }
        
        return UIApplication.shared.windows.first?.safeAreaInsets ?? defaultInsets
        
    }()
    
     static let isFringeScreen: Bool = {
        guard #available(iOS 11.0, *) else { return false }
        return UIApplication.shared.windows.first?.safeAreaInsets != UIEdgeInsets.zero
    }()
    
     static let appVersionStr: String = ((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "" )
     static let appBundleStr: String = ((Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? "" )
     static let appDisplayName: String = ((Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String) ?? "" )
     static let appBundleId: String = ((Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String) ?? "" )

     static let iosVersionStr: String = UIDevice.current.systemVersion
    
     static let cacheDir: String = (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first) ?? ""
     static let tempDir: String = NSTemporaryDirectory()
     static let documentDir: String = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first) ?? ""

     static var appIconName: String? {
        
        let bundleIconsOrEmpty: [String: Any]? = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any]
        guard let bundleIcons = bundleIconsOrEmpty else { return nil }
        
        let primaryIconOrEmpty = bundleIcons["CFBundlePrimaryIcon"] as? [String: Any]
        guard let primaryIcon = primaryIconOrEmpty else { return nil }
        
        let iconFilesOrEmpty = primaryIcon["CFBundleIconFiles"] as? [String]
        guard let iconFiles = iconFilesOrEmpty else { return nil }
        
        return iconFiles.last
        
    }
    
     static func jumpToSystemPrivacySettings() {
        
        guard let appSetting = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appSetting, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(appSetting)
        }
        
    }
    
//    // webview缓存
//     static func webviewCacheSize() -> UInt {
//
//    }
    
    // 0 .. 100
     static var screenBrightness: Int {
        #if os(iOS)
        return Int(UIScreen.main.brightness * 100)
        #else
        return 100
        #endif
    }
    
}

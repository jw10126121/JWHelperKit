//
//  WebView+State.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2018/10/27.
//  Copyright © 2018 Linjw. All rights reserved.
//

import UIKit


/// webView加载状态
public enum WebViewLoadState: Int {
    
    /// 默认
    case none
    /// 加载中
    case loading
    /// 加载成功
    case success
    /// 加载失败
    case fail
    
}

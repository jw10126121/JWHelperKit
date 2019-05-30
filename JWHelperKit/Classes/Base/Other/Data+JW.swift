//
//  Data+JW.swift
//
//
//  Created by Linjw on 2018/7/4.
//  Copyright © 2018年 Linjw. All rights reserved.
//

import Foundation
import UIKit

extension Data: JWNamespaceWrappable {
    
    fileprivate func toDeviceTokenStr() -> String {
         return self.map { String(format: "%02.2hhx", arguments: [$0]) }.joined()
    }
}

public extension JWNamespaceWrapper where T == Data {
    
    /// DeviceToken String
    var deviceTokenString: String { return jwWrappedValue.toDeviceTokenStr() }
    
}

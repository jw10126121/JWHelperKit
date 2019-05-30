//
//  UIControl+BounceAnimation.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2018/11/2.
//  Copyright © 2018 Linjw. All rights reserved.
//

import Foundation
import UIKit

/// UIView动画拓展
public extension JWNamespaceWrapper where T: UIView {
    
    func bounceAnimation() { jwWrappedValue.bounceAnimation() }
    
}

fileprivate extension UIView {
    
    /// 动画：变大后还原（点赞效果）
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0, 1.5, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = 0.3 * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        self.layer.add(impliesAnimation, forKey: nil)
    }
    
}

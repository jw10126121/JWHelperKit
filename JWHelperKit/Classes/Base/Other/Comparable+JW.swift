//
//  Comparable+JW.swift
//  AiXiaoYaApp
//
//  Created by linjw on 2019/6/14.
//  Copyright © 2019 Linjw. All rights reserved.
//

import UIKit


public extension Comparable {
    
    private func between(minValue: Self, maxValue: Self) -> Self {
        return min(max(self, minValue), maxValue)
    }
    
    func limit(range: ClosedRange<Self>) -> Self {
        let maxValue = range.upperBound
        let minValue = range.lowerBound
        return between(minValue: minValue, maxValue: maxValue)
    }
    
}

public extension ClosedRange {
    
    func limit(value: Bound) -> Bound {
        let maxValue = self.upperBound
        let minValue = self.lowerBound
        return Swift.min(Swift.max(value, minValue), maxValue)
    }
    
}



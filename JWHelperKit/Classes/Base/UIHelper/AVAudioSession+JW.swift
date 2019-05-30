//
//  AVAudioSession+JW.swift
//  Linjw
//
//  Created by linjw on 2018/11/12.
//  Copyright © 2018 Linjw. All rights reserved.
//

import Foundation
import AVFoundation

public extension JWNamespaceWrapper where T: AVAudioSession {
    
    /**
     设置音视频后台播放
     // 后台播放音频设置,需要在Capabilities->Background Modes中勾选Audio,Airplay,and Picture in Picture
     */
    static func configCategory(_ category: AVAudioSession.Category) {
        
        do {
            let audioSession = AVAudioSession.sharedInstance()
            if #available(iOS 10.0, *) {
                try audioSession.setCategory(category, mode: AVAudioSession.Mode.default)
            } else {
                audioSession.perform(NSSelectorFromString("setCategory:error:"), with: category)
            }
            try? audioSession.setActive(true)
            
        } catch let error {
            debugPrint("audioSession error:" + error.localizedDescription)
        }
        
    }
    
}

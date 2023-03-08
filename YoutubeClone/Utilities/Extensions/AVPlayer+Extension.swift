//
//  AVPlayer+Extension.swift
//  YoutubeClone
//
//  Created by mert can çifter on 28.02.2023.
//

import Foundation
import AVKit

extension AVPlayer {
    
    var isPlaying: Bool {
        get {
            return (self.rate != 0 && self.error == nil)
        }
    }
}

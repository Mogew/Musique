//
//  CMTime + Extension.swift
//  Musique
//
//  Created by sidzhe on 22.06.2023.
//

import Foundation
import AVKit

extension CMTime {
    
    func convertToString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return Const.Text.empty }
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormatString = String(format: Const.Text.format, minutes, seconds)
        return timeFormatString
        
    }
}

//
//  HapticManager.swift
//  SwiftuiCrypto
//
//  Created by Lori Rothermel on 5/7/23.
//

import Foundation
import SwiftUI


class HapticManager {
    static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}

//
//  Item.swift
//  SuperPay
//
//  Created by Zahid on 2025/11/07.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

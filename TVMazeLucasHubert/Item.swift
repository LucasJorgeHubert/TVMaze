//
//  Item.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
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

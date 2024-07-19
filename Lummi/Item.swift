//
//  Item.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 18/07/24.
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

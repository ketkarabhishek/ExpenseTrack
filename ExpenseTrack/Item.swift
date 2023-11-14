//
//  Item.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/14/23.
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

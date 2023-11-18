//
//  Expense.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/14/23.
//

import Foundation
import SwiftData

@Model
final class Expense {
    @Attribute(.unique) var id: UUID
    var name: String
    var amount: Float
    var timestamp: Date
    var paidBy: Person
    var split: [String: Int]
    
    init(id: UUID = UUID(), name: String, amount: Float, timestamp: Date, paidBy: Person, split: [String: Int] = [:]) {
        self.id = id
        self.timestamp = timestamp
        self.name = name
        self.amount = amount
        self.paidBy = paidBy
        self.split = split
    }
}

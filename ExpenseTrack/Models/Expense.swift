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
    var amount: Money
    var date: Date
    var paidBy: Person?
    var split: [String: Decimal]
    
    init(id: UUID = UUID(), name: String, amount: Money, timestamp: Date = Date.now, paidBy: Person? = nil, split: [String: Decimal] = [:]) {
        self.id = id
        self.date = timestamp
        self.name = name
        self.amount = amount
        self.paidBy = paidBy
        self.split = split
    }
}

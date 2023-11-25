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
    var amount: Decimal
    var currency: Currency
    var date: Date
    var paidBy: Person?
    var split: [SplitModel]?
    var splitType: SplitType
    var group: Group?
    
    init(id: UUID = UUID(), name: String, amount: Decimal, currency: Currency, date: Date = Date.now, paidBy: Person? = nil, split: [SplitModel]? = [], splitType: SplitType, group: Group? = nil) {
        self.id = id
        self.name = name
        self.amount = amount
        self.currency = currency
        self.date = date
        self.paidBy = paidBy
        self.split = split
        self.splitType = splitType
        self.group = group
    }
    
}

enum SplitType: String, Codable, CaseIterable, Identifiable  {
    
    case equal, custom
    
    var id: Self { self }
}

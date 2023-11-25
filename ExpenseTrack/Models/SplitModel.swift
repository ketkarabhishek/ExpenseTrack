//
//  Split.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/23/23.
//

import Foundation
import SwiftData

@Model
final class SplitModel {
    @Attribute(.unique) var id: UUID
    var share: Decimal
    var spent: Decimal
//    var expense: Expense?
    var person: Person?
    
    var netBalance: Decimal {
        return share - spent
    }
    
    init(id: UUID = UUID(), share: Decimal, spent: Decimal, person: Person? = nil) {
        self.id = id
        self.share = share
        self.spent = spent
//        self.expense = expense
        self.person = person
    }
    
}


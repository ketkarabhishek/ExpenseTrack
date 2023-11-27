//
//  Group.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/14/23.
//

import Foundation
import SwiftData

@Model
final class Group {
    @Attribute(.unique) var id: UUID
    var name: String
    var fromDate: Date
    var toDate: Date
    var people:[Person]
    var expenses: [Expense]
    var splits: [SplitModel]
    
    init(id: UUID = UUID(), name: String, fromDate: Date, toDate: Date, people:[Person] = [], expenses:[Expense] = [], splits: [SplitModel] = []) {
        self.id = id
        self.fromDate = fromDate
        self.toDate = toDate
        self.name = name
        self.people = people
        self.expenses = expenses
        self.splits = splits
    }
}

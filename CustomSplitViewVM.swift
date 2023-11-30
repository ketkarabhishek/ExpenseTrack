//
//  CustomSplitViewVM.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/30/23.
//

import Foundation

@Observable
class CustomSplitViewVM{
    let people: [Person]
    let totalAmount: Decimal
    
    var diff: Decimal {
        return totalAmount - share.values.reduce(0, +)
    }
    var share: [String: Decimal]
    
    init(people: [Person], totalAmount: Decimal) {
        self.people = people
        self.totalAmount = totalAmount
        share = [:]
    }
}

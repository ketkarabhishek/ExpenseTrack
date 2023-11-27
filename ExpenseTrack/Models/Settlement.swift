//
//  Settlements.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/25/23.
//

import Foundation

struct Settlement: Hashable {
    let payer: Person
    let reciever: Person
    let amount: Decimal
}

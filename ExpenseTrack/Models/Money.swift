//
//  Money.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/22/23.
//

import Foundation
//import SwiftData

//@Model
//final class Money {
//   enum Currency: String {
//      case USD, EUR, INR, CNY
//   }
//    
//    var amount: Decimal
//    var currency: Currency
//    
//    init(amount: Decimal, currency: Currency) {
//        self.amount = amount
//        self.currency = currency
//    }
//}
struct Money: Codable{
    var amount: Decimal
    let currency: Currency
    
    init(amount: Decimal, currency: Currency) {
        self.amount = amount
        self.currency = currency
    }
}

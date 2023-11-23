//
//  Currency.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/22/23.
//

import Foundation

//struct Currency: Codable {
//    let code: String
//    let symbol: String
//    let name: String
//}
//
//extension Currency {
//    static let USD = Currency(code: "USD",
//                              symbol: "$",
//                              name: "US Dollar")
//    static let CNY = Currency(code: "CNY",
//                              symbol: "¥",
//                              name: "Chinese Yuan Renminbi")
//}

enum Currency: String, Codable, CaseIterable, Identifiable  {
    
    case USD, EUR, GBP, CNY // supported currencies here
    
    var id: Self { self }
    
//    var symbol: String {
//        switch self {
//        case .USD: return "$"
//        case .EUR:
//        case .GBP:
//        case .CNY:
//        }
//    }
}


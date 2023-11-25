//
//  Currency.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/22/23.
//

import Foundation


enum Currency: String, Codable, CaseIterable, Identifiable  {
    
    case USD, EUR
    
    var id: Self { self }
}


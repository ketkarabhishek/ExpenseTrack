//
//  ExpensesView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/17/23.
//

import SwiftUI

struct ExpensesView: View {
    
    let expenses: [Expense]

    
    var body: some View {
        List(expenses) { item in
            VStack(alignment: .leading, spacing: 8){
                Text(item.name)
                    .font(.title2)
                Text("\(item.paidBy?.name ?? "Payer") paid \(item.amount.formatted()) \(item.currency.rawValue)")
                    .font(.subheadline)
            }
        }
        
        
    }
}

//#Preview {
//    ExpensesView(expenses: [Expense(name: "Test 1", amount: Money(amount: 100, currency: .USD), split: [])])
//}

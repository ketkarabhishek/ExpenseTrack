//
//  ExpensesView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/17/23.
//

import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) private var modelContext
    let expenses: [Expense]

    
    var body: some View {
        List {
            ForEach(expenses){item in
                if item.isRepayment{
                    Text(item.name)

                } else {
                    VStack(alignment: .leading, spacing: 8){
                        Text(item.name)
                            .font(.title2)
                        Text("\(item.paidBy?.name ?? "Payer") paid \(item.amount.formatted()) \(item.currency.rawValue)")
                            .font(.subheadline)
                    }
                }
            }
            .onDelete(perform: removeExpense)
        }
        
    }
    private func removeExpense(at indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(expenses[index])
        }
    }
}

#Preview {
    ExpensesView(expenses: [Expense(name: "Test 1", amount: 100, currency: .USD, split: [], splitType: .equal)])
}

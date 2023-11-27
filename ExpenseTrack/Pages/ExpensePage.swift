//
//  ExpensePage.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/18/23.
//

import SwiftUI

struct ExpensePage: View {
    
    @Environment(\.modelContext) private var modelContext
    var group: Group
    @State private var presentAddSheet: Bool = false
    @State private var presentSettleSheet: Bool = false
    
    var body: some View {
        ExpensesView(expenses: group.expenses)
            .navigationTitle(group.name)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        presentAddSheet.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        presentAddSheet.toggle()
                    }) {
                        Label("Edit Trip", systemImage: "square.and.pencil")
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        presentSettleSheet.toggle()
                    }, label: {
                        Text("Settle Up")

                    })
                }
            }
            .sheet(isPresented: $presentAddSheet, content: {
                AddExpenseView(isPresented: $presentAddSheet, allMembers: group.people) { newExpense, paidBy, splits in
                    addItem(newExpense: newExpense, paidBy: paidBy, splits: splits)
                }
            })
            .sheet(isPresented: $presentSettleSheet, content: {
                SettleView(group: group)
            })
    }
}

extension ExpensePage{
    private func addItem(newExpense: Expense, paidBy: Person, splits: [SplitModel]) {
        withAnimation {
            group.expenses.append(newExpense)
            newExpense.paidBy = paidBy
            newExpense.split = splits
            group.splits.append(contentsOf: splits)
            presentAddSheet.toggle()
        }
    }
}

//#Preview {
//    ExpensePage(group: Group(name: "Test", fromDate: Date(), toDate: Date()))
//}

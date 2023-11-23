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
    
    var body: some View {
        ExpensesView(expenses: group.expenses)
            .navigationTitle(group.name)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        presentAddSheet.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $presentAddSheet, content: {
                AddExpenseView(isPresented: $presentAddSheet, allMembers: group.people) { newExpense, selectedMember in
                    addItem(newExpense: newExpense, selected: selectedMember)
                }
            })
    }
}

extension ExpensePage{
    private func addItem(newExpense: Expense, selected: Person) {
        withAnimation {
            group.expenses.append(newExpense)
            newExpense.paidBy = selected
            presentAddSheet.toggle()
        }
    }
}

#Preview {
    ExpensePage(group: Group(name: "Test", fromDate: Date(), toDate: Date()))
}

//
//  ExpensePage.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/18/23.
//

import SwiftUI

struct ExpensePage: View {
    
    @State private var vm: ExpensePageVM
    
    init(group: Group) {
        _vm = State(initialValue: ExpensePageVM(group: group))
    }
    
    var body: some View {
        ExpensesView(expenses: vm.group.expenses)
            .navigationTitle(vm.group.name)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        vm.presentAddSheet.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        vm.presentEditGroupSheet.toggle()
                    }) {
                        Label("Edit Trip", systemImage: "square.and.pencil")
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        vm.presentSettleSheet.toggle()
                    }, label: {
                        Text("Settle Up")

                    })
                }
            }
            .sheet(isPresented: $vm.presentAddSheet, content: {
                AddExpenseView(isPresented: $vm.presentAddSheet, allMembers: vm.group.people) { newExpense, paidBy, splits in
                    vm.addExpense(newExpense: newExpense, paidBy: paidBy, splits: splits)
                }
            })
            .sheet(isPresented: $vm.presentSettleSheet, content: {
                SettleView(group: vm.group)
            })
            .sheet(isPresented: $vm.presentEditGroupSheet, content: {
                GroupEditorPage(isPresented: $vm.presentEditGroupSheet, group: vm.group) { _ in
                    
                }
            })
    }
}


extension ExpensePage{
    
    @Observable
    class ExpensePageVM{
        var group: Group
        var presentAddSheet: Bool = false
        var presentSettleSheet: Bool = false
        var presentEditGroupSheet: Bool = false
        
        init(group: Group) {
            self.group = group
        }
        
        func addExpense(newExpense: Expense, paidBy: Person, splits: [SplitModel]) {
            withAnimation {
                group.expenses.append(newExpense)
                newExpense.paidBy = paidBy
                newExpense.split = splits
                group.splits.append(contentsOf: splits)
                presentAddSheet.toggle()
            }
        }
    }
}

#Preview {
    ExpensePage(group: Group(name: "Test", fromDate: Date(), toDate: Date()))
}

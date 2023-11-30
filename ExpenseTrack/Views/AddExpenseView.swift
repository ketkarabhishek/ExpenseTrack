//
//  AddExpenseView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/17/23.
//

import SwiftUI

struct AddExpenseView: View {
    
    @Binding var isPresented: Bool
    let allMembers:[Person]
    let onSubmitExpense: (Expense, Person, [SplitModel]) -> Void

    
    @State private var vm = AddExpenseVM()
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Expense Name") {
                    TextField(text: $vm.name) {
                        Text("Enter name here")
                    }
                }
                Section("Amount") {
                    Picker("Currency", selection: $vm.selectedCurrency) {
                        ForEach(Currency.allCases, id: \.self) { member in
                            Text(member.rawValue)
                        }
                    }
                    TextField(value: $vm.amount, format: .number, label: {
                        Text("Enter amount")
                    })
                    .keyboardType(.decimalPad)
                    .onChange(of: vm.amount) {
                        guard vm.selectedSplitType == .equal else {
                            return
                        }
                        
                        vm.updateEqualSplits()
                    }
                }
                
                Picker("Paid By", selection: $vm.selectPaidBy) {
                    ForEach(allMembers, id: \.self) { member in
                        Text(member.name)
                    }
                }
                
                Section("Split") {
                    Picker("Split", selection: $vm.selectedSplitType) {
                        ForEach(SplitType.allCases, id: \.self) { member in
                            Text(member.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    if vm.selectedSplitType == .custom {
                        NavigationLink {
                            CustomSplitView(people: allMembers, totalAmount: vm.amount) { newShares in
                                vm.sharesMap = newShares
                            }
                            Text("Custom Split")
                        } label: {
                            Text("Custom Split")
                        }
                    }
                }
                
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        guard !vm.name.isEmpty || vm.amount > 0 else {
                            return
                        }
                        
                        guard vm.verifyTotal() else {
                            return
                        }
                        let res = vm.createExpense()
                        onSubmitExpense(res.0, res.1, res.2)
                    } label: {
                        Text("Add")
                    }

                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Text("Cancel")
                    }

                }
            }
            .onAppear{
                vm.allMembers = allMembers
                vm.selectPaidBy = allMembers[0]
            }
        }
    }
}

#Preview {
    AddExpenseView(isPresented: .constant(true), allMembers: [Person(name: "Alex")]){ _,_,_ in
        
    }
}

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
    let onSubmit: (Expense, Person) -> Void
    
    @State private var name: String = ""
    @State private var amount: Decimal = 0
    @State private var memberText: String = ""
    @State private var isCustomSplit: Bool = false
    @State private var selectedMember: Person = Person(name: "Select")
    @State private var split: [String: Decimal] = [:]
    @State private var selectedCurrency: Currency = .USD
    
    
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Expense Name") {
                    TextField(text: $name) {
                        Text("Enter name here")
                    }
                }
                Section("Amount") {
                    Picker("Currency", selection: $selectedCurrency) {
                        ForEach(Currency.allCases, id: \.self) { member in
                            Text(member.rawValue)
                        }
                    }
                    TextField(value: $amount, format: .number, label: {
                        Text("Enter amount")
                    })
                    .keyboardType(.decimalPad)
                    .onChange(of: amount) {
                        guard !isCustomSplit else {
                            return
                        }
                        let s = amount / Decimal(allMembers.count)
                        for m in allMembers{
                            split[m.id.uuidString] = s
                        }
                        
                    }
                }
                
                Picker("Paid By", selection: $selectedMember) {
                    ForEach(allMembers, id: \.self) { member in
                        Text(member.name)
                    }
                }
//                .pickerStyle(NavigationLinkPickerStyle())
                
                Section("Split") {
                    Toggle(isOn: $isCustomSplit) {
                        Text("CustomSplit")
                    }
                    
                    if isCustomSplit {
                        NavigationLink {
                            CustomSplitView(split: $split, people: allMembers, totalAmount: amount)
                        } label: {
                            Text("Custom Split")
                        }
                    }
                }
                
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        guard !name.isEmpty || amount > 0 else {
                            return
                        }
                        let newExpense = Expense(name: name, amount: Money(amount: amount, currency: selectedCurrency), split: split)
                        onSubmit(newExpense, selectedMember)
                    } label: {
                        Text("Add")
                    }

                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Text("Cancel")
                    }

                }
            }
            .onAppear{
                selectedMember = allMembers[0]
            }
        }
    }
}

#Preview {
    AddExpenseView(isPresented: .constant(true), allMembers: [Person(name: "Alex")]){ _, _ in
        
    }
}

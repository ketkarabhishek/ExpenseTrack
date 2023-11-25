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
    
    @State private var name: String = ""
    @State private var amount: Decimal = 100
    @State private var selectedCurrency: Currency = .USD
    @State private var selectPaidBy: Person = Person(name: "Select")
    @State private var splits: [SplitModel] = []
    @State private var selectedSplitType: SplitType = .equal
    
    @State private var sharesMap: [String: Decimal] = [:]
    
    
    
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
                        guard selectedSplitType == .equal else {
                            return
                        }
                        
                        updateEqualSplits()
                    }
                }
                
                Picker("Paid By", selection: $selectPaidBy) {
                    ForEach(allMembers, id: \.self) { member in
                        Text(member.name)
                    }
                }
                
                Section("Split") {
                    Picker("Split", selection: $selectedSplitType) {
                        ForEach(SplitType.allCases, id: \.self) { member in
                            Text(member.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    if selectedSplitType == .custom {
                        NavigationLink {
                            CustomSplitView(people: allMembers, totalAmount: amount) { newShares in
                                sharesMap = newShares
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        guard !name.isEmpty || amount > 0 else {
                            return
                        }
                        submitExpense()
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
                selectPaidBy = allMembers[0]
                
            }
        }
    }
}

extension AddExpenseView {
    func updateEqualSplits(){
        let share = amount / 3
        for m in allMembers{
            sharesMap[m.id.uuidString] = share
        }
    }
    
    func generateSplits() -> [SplitModel] {
        var res: [SplitModel] = []
        for m in allMembers{
            res.append(SplitModel(share: sharesMap[m.id.uuidString] ?? 0, spent: m == selectPaidBy ? amount : 0, person: m))
        }
        return res
    }
    
    func submitExpense(){
        guard sharesMap.values.reduce(0,+) > 0 else{
            return
        }
        let splits = generateSplits()
        let newExpense = Expense(name: name, amount: amount, currency: selectedCurrency, splitType: selectedSplitType)
        onSubmitExpense(newExpense, selectPaidBy, splits)
    }
}


#Preview {
    AddExpenseView(isPresented: .constant(true), allMembers: [Person(name: "Alex")]){ _,_,_ in
        
    }
}

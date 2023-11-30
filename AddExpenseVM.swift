//
//  AddExpenseVM.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/30/23.
//

import Foundation

@Observable
class AddExpenseVM {
    var allMembers:[Person] = []
    
    var name: String = ""
    var amount: Decimal = 100
    var selectedCurrency: Currency = .USD
    var selectPaidBy: Person = Person(name: "Select")
    var splits: [SplitModel] = []
    var selectedSplitType: SplitType = .equal
    
    var sharesMap: [String: Decimal] = [:]
    
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
    
    func verifyTotal() -> Bool {
        if sharesMap.values.reduce(0,+) > 0 {
            return true
        }
        return false
    }
    
    func createExpense() -> (Expense, Person, [SplitModel]){
        let splits = generateSplits()
        let newExpense = Expense(name: name, amount: amount, currency: selectedCurrency, splitType: selectedSplitType)
        return (newExpense, selectPaidBy, splits)
    }
    
}

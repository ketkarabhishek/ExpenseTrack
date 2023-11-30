//
//  SettleView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/25/23.
//

import SwiftUI
import SwiftData

struct SettleView: View {

    @State private var vm: SettleViewVM
    
    init(group: Group) {
        _vm = State(initialValue: SettleViewVM(group: group))
    }
    
    
    var body: some View {
        NavigationStack{
            List(vm.settelments, id: \.self){s in
                Text("\(s.payer.name) owes \(s.reciever.name) \(s.amount.formatted())")
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("Settle")
                }
            }
            .onAppear{
                vm.calculateTotalNets()
                vm.generateSettlements()
            }
        }
    }
}


#Preview {
    SettleView(group: Group(name: "Test", fromDate: Date.now, toDate: Date.now))
}

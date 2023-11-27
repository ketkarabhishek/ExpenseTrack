//
//  SettleView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/25/23.
//

import SwiftUI
import SwiftData

struct SettleView: View {
    
    var group: Group
    @Environment(\.modelContext) private var modelContext
    @State private var netValues: [Person: Decimal] = [:]
    @State private var settelments: [Settlement] = []
    
    
    var body: some View {
        List(settelments, id: \.self){s in
            Text("\(s.payer.name) owes \(s.reciever.name) \(s.amount.formatted())")
        }
        .onAppear{
            calculateTotalNets()
            generateSettlements()
        }
    }
}

extension SettleView{
    func calculateTotalNets(){
        for p in group.people{
            let filteredSplits = group.splits.filter { sp in
                return sp.person?.id.uuidString == p.id.uuidString
            }
            let net = filteredSplits.reduce(0) { prev, sp in
                return prev + sp.netBalance
            }
            netValues[p] = net
        }
//        print(netValues.description)
    }
    
    func generateSettlements(){
        var owed = netValues.filter({$0.value < 0})
        var owes = netValues.filter({$0.value > 0})
        
        for k1 in owed.keys{
            for k2 in owes.keys{
                let transferAmt = min(abs(owed[k1] ?? 0), abs(owes[k2] ?? 0))
                
                owed[k1] = owed[k1] ?? 0  + transferAmt
                owes[k2] = owed[k2] ?? 0 - transferAmt
                
                settelments.append(Settlement(payer: k2, reciever: k1, amount: transferAmt))
                
                if owed[k1] == 0{
                    break
                }
            }
        }
        
        print(settelments.description)
    }
}

#Preview {
    SettleView(group: Group(name: "Test", fromDate: Date.now, toDate: Date.now))
}

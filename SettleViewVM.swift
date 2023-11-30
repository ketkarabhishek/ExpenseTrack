//
//  SettleViewVM.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/30/23.
//

import Foundation

@Observable
class SettleViewVM {
    var group: Group
    var netValues: [Person: Decimal]
    var settelments: [Settlement]
    
    init(group: Group, netValues: [Person : Decimal] = [:], settelments: [Settlement] = []) {
        self.group = group
        self.netValues = netValues
        self.settelments = settelments
    }
    
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
    }
}

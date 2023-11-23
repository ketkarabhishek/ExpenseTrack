//
//  CustomSplitView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/20/23.
//

import SwiftUI

struct CustomSplitView: View {
    @Environment(\.dismiss) var dismiss
    @State private var customSplit: [String: Decimal] = [:]
    @State private var diff: Decimal = 0
    
    @Binding var split: [String : Decimal]
    
    let people: [Person]
    let totalAmount: Decimal
    
    
    var body: some View {
        Form {
            Section{
                ForEach(people, id: \.self) { member in
                    SplitTextFieldView(id: member.id.uuidString, name: member.name, onChangeValue: { id, value in
                        customSplit[id] = value
                    })
                    .onChange(of: customSplit) {
                        let sum = customSplit.values.reduce(0){$0 + $1}
                        diff = totalAmount - sum
                    }
                }
            } footer: {
                if diff < 0 {
                    Text("$\(abs(diff).description) over.")
                }
                
                if diff > 0 {
                    Text("$\(abs(diff).description) left.")
                        
                }
            }
            
        }
        .toolbar{
            ToolbarItem{
                Button(action: {
                    guard diff == 0 else{
                        return
                    }
                    split = customSplit
                    dismiss()
                }, label: {
                    Text("Save")
                })
            }
        }
    }
}

//#Preview {
//    CustomSplitView(split: .constant([:]), people: [], totalAmount: 0)
//}

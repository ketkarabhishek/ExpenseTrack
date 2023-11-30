//
//  CustomSplitView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/20/23.
//

import SwiftUI

struct CustomSplitView: View {

    @Environment(\.dismiss) var dismiss
    @State private var vm: CustomSplitViewVM
    
    private let onSubmit: ([String: Decimal]) -> Void
    
    init(people:[Person], totalAmount: Decimal, onSubmit: @escaping ([String : Decimal]) -> Void) {
        let vm = CustomSplitViewVM(people: people, totalAmount: totalAmount)
        _vm = State(initialValue: vm)
        self.onSubmit = onSubmit
    }

    
    var body: some View {
        Form {
            Section{
                ForEach(vm.people, id: \.self){s in
                    SplitTextFieldView(id: s.id.uuidString, name: s.name) { id, value in
                        vm.share[id] = value
                    }
                }
            } footer: {
                if vm.diff < 0 {
                    Text("$\(abs(vm.diff).description) over")
                        .foregroundStyle(.red)
                }
                
                if vm.diff > 0 {
                    Text("$\(abs(vm.diff).description) left")
                        .font(.callout)
                        .foregroundStyle(.blue)
                        
                }
            }
            
        }
        .toolbar{
            ToolbarItem{
                Button(action: {
                    guard vm.diff == 0 else{
                        return
                    }
                    onSubmit(vm.share)
                    dismiss()
                }, label: {
                    Text("Save")
                })
            }
        }
    }
}


#Preview {
    CustomSplitView(people: [Person(name: "Test1")], totalAmount: 50){_ in
        
    }
}

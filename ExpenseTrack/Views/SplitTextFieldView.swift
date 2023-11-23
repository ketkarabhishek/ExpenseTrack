//
//  SplitTextFieldView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/20/23.
//

import SwiftUI

struct SplitTextFieldView: View {
    let id: String
    let name: String
    let onChangeValue: (String, Decimal) -> Void
    
    @State private var text: Decimal = 0
    
    var body: some View {
        HStack{
            Text(name)
            TextField(value: $text, format: .number, label: {
                Text("$")
            })
            .multilineTextAlignment(.trailing)
            .onChange(of: text) {
                onChangeValue(id, text)
            }
        }
    }
}

#Preview {
    SplitTextFieldView(id: "", name: "Alex"){ _, _ in
        
    }
}

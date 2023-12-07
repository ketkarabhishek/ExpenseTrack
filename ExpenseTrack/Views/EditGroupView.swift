//
//  EditGroupView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 12/3/23.
//

import SwiftUI

struct EditGroupView: View {
    @Binding var name: String
    @Binding var memberText: String
    @Binding var members: [Person]
    @Binding var start: Date
    @Binding var end: Date
    
    var addMember: ()->Void
    var removeMember: (Person)->Void
    
    var body: some View {
        Form{
            Section("Name") {
                TextField(text: $name) {
                    Text("Group Name")
                }
            }
            
            Section("Duration") {
                DatePicker(
                    "Start Date",
                    selection: $start,
                    displayedComponents: [.date]
                )
                DatePicker(
                    "End Date",
                    selection: $end,
                    displayedComponents: [.date]
                )
            }
            
            Section("Members") {
                HStack {
                    TextField(text: $memberText) {
                        Text("Add Members")
                            
                    }
                    Button(action: {
                        addMember()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                ForEach($members){ $member in
                    HStack{
                        Text(member.name)
                        Spacer()
                        Button(action: {
                            removeMember(member)
                        }, label: {
                            Image(systemName: "minus.circle")
                        })
                    }
                }
            }
            
        }

    }
}

#Preview {
    EditGroupView(name: .constant("Beach"), memberText: .constant(""), members: .constant([]), start: .constant(Date.now), end: .constant(Date.now)) {
        
    } removeMember: { _ in
        
    }

}

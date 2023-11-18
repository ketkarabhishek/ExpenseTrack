//
//  AddGroupView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/16/23.
//

import SwiftUI

struct AddGroupView: View {
    @Binding var isPresented: Bool
    @State var name: String = ""
    @State var memberText: String = ""
    @State var members: [Person] = []
    @State private var start = Date()
    @State private var end = Date()
    
    let onSubmit: (Group) -> Void

    var body: some View {
        NavigationStack {
            List{
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
                            if memberText.isEmpty {
                                return
                            }
                            members.append(Person(name: memberText))
                            memberText = ""
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                    ForEach(members){ member in
                        HStack{
                            Text(member.name)
                            Spacer()
                            Button(action: {
                                if let index =  members.firstIndex(of: member){
                                    members.remove(at: index)
                                }
                            }, label: {
                                Image(systemName: "minus.circle")
                            })
                        }
                    }
                }
                
            }
            .navigationTitle("New Group")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if members.isEmpty{
                            return
                        }
                        let newGroup = Group(name: name, fromDate: start, toDate: end, people: members)
                        onSubmit(newGroup)
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
        }
    }
}

#Preview {
    AddGroupView(isPresented: .constant(true)) { _ in
        
    }
}

//
//  AddGroupView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/16/23.
//

import SwiftUI

struct AddGroupView: View {
    @Binding var isPresented: Bool
    let onSubmit: (Group) -> Void
    
    @State private var vm: AddGroupVM
    
    init(isPresented: Binding<Bool>, onSubmit: @escaping (Group) -> Void) {
        _isPresented = isPresented
        self.onSubmit = onSubmit
        _vm = State(initialValue: AddGroupVM())
    }

    var body: some View {
        NavigationStack {
            List{
                Section("Name") {
                    TextField(text: $vm.name) {
                        Text("Group Name")
                    }
                }
                
                Section("Duration") {
                    DatePicker(
                        "Start Date",
                        selection: $vm.start,
                        displayedComponents: [.date]
                    )
                    DatePicker(
                        "End Date",
                        selection: $vm.end,
                        displayedComponents: [.date]
                    )
                }
                
                Section("Members") {
                    HStack {
                        TextField(text: $vm.memberText) {
                            Text("Add Members")
                                
                        }
                        Button(action: {
                            vm.addMember()
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                    ForEach(vm.members){ member in
                        HStack{
                            Text(member.name)
                            Spacer()
                            Button(action: {
                                vm.removeMember(person: member)
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
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        if let newGroup = vm.createNewGroup() {
                            onSubmit(newGroup)
                        }
                    } label: {
                        Text("Add")
                    }

                }
                
                ToolbarItem(placement: .cancellationAction) {
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

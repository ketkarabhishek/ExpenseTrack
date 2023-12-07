//
//  AddGroupView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/16/23.
//

import SwiftUI

struct GroupEditorPage: View {
    @Binding var isPresented: Bool
    
    @State private var vm: AddGroupVM
    
    init(isPresented: Binding<Bool>, group: Group?, onSubmit: @escaping (Group) -> Void) {
        _isPresented = isPresented
        _vm = State(initialValue: AddGroupVM(group: group, onSubmit: onSubmit))
    }

    var body: some View {
        
        NavigationStack {
            EditGroupView(name: $vm.name, memberText: $vm.memberText, members: $vm.members, start: $vm.start, end: $vm.end, addMember: vm.addMember, removeMember: vm.removeMember)
                .navigationTitle(vm.group == nil ? "Add Group" : "Edit Group")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            vm.save()
                            isPresented = false
                        } label: {
                            Text("Save")
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
    GroupEditorPage(isPresented: .constant(true), group: nil) { _ in
        
    }
}

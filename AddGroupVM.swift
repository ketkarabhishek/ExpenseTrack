//
//  AddGroupVM.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/30/23.
//

import Foundation

@Observable
class AddGroupVM {
    var group: Group?
    var name: String = ""
    var memberText: String = ""
    var members: [Person] = []
    var start = Date()
    var end = Date()
    
    let onSubmit: (Group) -> Void
    
    init(group: Group?, onSubmit: @escaping (Group) -> Void) {
        self.group = group
        self.onSubmit = onSubmit
        if let group = group{
            self.name = group.name
            self.members = group.people
            self.start = group.fromDate
            self.end = group.toDate
        }
    }
    
    func save(){
        if let group = group{
            group.name = name
            group.people = members
            group.fromDate = start
            group.toDate = end
        }
        else{
            guard !members.isEmpty || !name.isEmpty else{
                return
            }
            
            onSubmit(Group(name: name, fromDate: start, toDate: end, people: members))
        }
    }
    
    func addMember() {
        if memberText.isEmpty {
            return
        }
        members.append(Person(name: memberText))
        memberText = ""
    }
    
    func removeMember(_ person: Person) {
        if let index =  members.firstIndex(of: person){
            members.remove(at: index)
        }
    }
    
}

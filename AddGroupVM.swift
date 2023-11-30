//
//  AddGroupVM.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/30/23.
//

import Foundation

@Observable
class AddGroupVM {
    var name: String = ""
    var memberText: String = ""
    var members: [Person] = []
    var start = Date()
    var end = Date()
    
    
    func addMember() {
        if memberText.isEmpty {
            return
        }
        members.append(Person(name: memberText))
        memberText = ""
    }
    
    func removeMember(person: Person) {
        if let index =  members.firstIndex(of: person){
            members.remove(at: index)
        }
    }
    
    func createNewGroup() -> Group? {
        guard !members.isEmpty || !name.isEmpty else{
            return nil
        }
        return Group(name: name, fromDate: start, toDate: end, people: members)
    }
}

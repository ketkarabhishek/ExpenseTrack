//
//  Person.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/17/23.
//

import Foundation
import SwiftData

@Model
final class Person {
    @Attribute(.unique) var id: UUID
    var name: String
    var email: String
    
    
    init(id: UUID = UUID(), name: String, email: String = "") {
        self.id = id
        self.name = name
        self.email = email
    }
}

//
//  GroupsView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/15/23.
//

import SwiftUI
import SwiftData


struct GroupsView: View {
    @Environment(\.modelContext) private var modelContext
    let groups: [Group]
    
    var body: some View {
        List {
            ForEach(groups) { item in
                NavigationLink {
                    ExpensePage(group: item)
                    
                } label: {
                    VStack(alignment: .leading, spacing: 8){
                        Text(item.name)
                        HStack{
                            Text(item.fromDate.formatted(.dateTime.day().month().year(.twoDigits)) + " to " + item.toDate.formatted(.dateTime.day().month().year(.twoDigits)))
                                .fontWeight(.thin)
                        }
                    }
                }
            }
            .onDelete(perform: removeGroup)
        }
        .navigationTitle("Groups")
        
    }
    
    private func removeGroup(at indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(groups[index])
        }
    }
}

#Preview {
    NavigationStack{
        GroupsView(groups: [Group(name: "Test", fromDate: Date.now, toDate: Date.now)])
    }
}

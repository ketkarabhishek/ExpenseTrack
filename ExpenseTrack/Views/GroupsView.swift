//
//  GroupsView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/15/23.
//

import SwiftUI
import SwiftData


struct GroupsView: View {
    var groups: [Group]
    let insertGroup: () -> Void
    let deleteGroups: (IndexSet) -> Void
    
    var body: some View {
        List {
            ForEach(groups) { item in
                NavigationLink {
                    Text(item.name)
                    
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
            .onDelete(perform: deleteGroups)
        }
        .navigationTitle("Trips")
        
    }
}

#Preview {
    NavigationStack{
        GroupsView(groups: [Group(name: "Test", fromDate: Date.now, toDate: Date.now)], insertGroup: {}) { _ in
            
        }
    }
}

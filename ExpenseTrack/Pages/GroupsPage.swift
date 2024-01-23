//
//  GroupsPage.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/17/23.
//

import SwiftUI
import SwiftData

struct GroupsPage: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var groups: [Group]
    @State private var presentAddSheet: Bool = false
    
    var body: some View {
        NavigationSplitView {
            GroupsView(groups: groups)
            .sheet(isPresented: $presentAddSheet, content: {
                GroupEditorPage(isPresented: $presentAddSheet, group: nil) { newGroup in
                    addItem(newGroup: newGroup)
                }
            })
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        presentAddSheet.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a Trip.")
        }
    }
    
}

extension GroupsPage{
    private func addItem(newGroup: Group) {
        withAnimation {
            modelContext.insert(newGroup)
            presentAddSheet.toggle()
        }
    }
}

#Preview {
    GroupsPage()
}

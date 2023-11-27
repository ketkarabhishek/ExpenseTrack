//
//  ContentView.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/14/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
       GroupsPage()
    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Group.self, configurations: config)

    return ContentView()
        .modelContainer(container)
    
}

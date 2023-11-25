//
//  ExpenseTrackApp.swift
//  ExpenseTrack
//
//  Created by Abhishek Ketkar on 11/14/23.
//

import SwiftUI
import SwiftData

@main
struct ExpenseTrackApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Group.self,
            Expense.self,
            Person.self,
            SplitModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

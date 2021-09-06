//
//  fjsApp.swift
//  fjs
//
//  Created by Dan Ackerman on 9/6/21.
//

import SwiftUI

@main
struct fjsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

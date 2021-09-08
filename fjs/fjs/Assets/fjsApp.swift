//
//  fjsApp.swift
//  fjs
//
//  Created by Dan Ackerman on 9/6/21.
//

import SwiftUI
import CoreData


@main
struct fjsApp: App {
    let persistenceController = PersistenceController.shared
 
    init() {
        // let see if this works
        
        persistenceController.fetchLocations(completion: {_ , error in
            if let error=error {
                print(error)
                return
            }
        })
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }
}

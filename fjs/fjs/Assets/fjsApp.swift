//
//  fjsApp.swift
//  fjs
//
//  Created by Dan Ackerman on 9/6/21.
//

import SwiftUI
import CoreData
import UserNotifications

@main
struct fjsApp: App {
    let persistenceController = PersistenceController.shared
 
    init() {
        persistenceController.fetchAllLocations(completion: { error in
            if let error=error {
                print(error)
                return
            }
        })
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])  {
                 success, error in
                     if success {
                         print("authorization granted")
                     } else if error != nil {
                        print("Error: \(String(describing: error)) ")
                     }
             }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    UIApplication.shared.applicationIconBadgeNumber = 0 }
            
        }
    }
}

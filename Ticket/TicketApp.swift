//
//  TicketApp.swift
//  Ticket
//
//  Created by Leo Powers on 6/30/23.
//

import SwiftUI

@main
struct TicketApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  DiceeApp.swift
//  Dicee
//
//  Created by Kenny Cabral on 2/13/22.
//

import SwiftUI

@main
struct DiceeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

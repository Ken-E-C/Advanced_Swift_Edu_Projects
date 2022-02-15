//
//  SwiftUIHealthKitApp.swift
//  SwiftUIHealthKit
//
//  Created by Kenny Cabral on 2/14/22.
//

import SwiftUI

@main
struct SwiftUIHealthKitApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

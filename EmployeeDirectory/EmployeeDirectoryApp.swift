//
//  EmployeeDirectoryApp.swift
//  EmployeeDirectory
//
//  Created by Vivek M on 31/05/22.
//

import SwiftUI

@main
struct EmployeeDirectoryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

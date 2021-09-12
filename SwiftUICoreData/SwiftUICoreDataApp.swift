//
//  SwiftUICoreDataApp.swift
//  SwiftUICoreData
//
//  Created by Will Wang on 9/12/21.
//

import SwiftUI

@main
struct SwiftUICoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

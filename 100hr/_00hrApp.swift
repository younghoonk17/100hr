//
//  _00hrApp.swift
//  100hr
//
//  Created by young hoon kim on 1/02/23.
//

import SwiftUI

@main
struct _00hrApp: App {
    @StateObject var appData = AppData()
    
    let persistenceController = PersistenceController.shared


    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext,persistenceController.container.viewContext)
                .id(appData.rootViewId)
                .environmentObject(appData)
        }
    }
}

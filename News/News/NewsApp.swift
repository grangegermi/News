//
//  NewsApp.swift
//  News
//
//  Created by Даша Волошина on 17.05.25.
//

import SwiftUI

@main
struct NewsApp: App {
    @StateObject var network = NetworkService()
    @StateObject var dataService = DataServices()
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(network)
                .environmentObject(dataService)  
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

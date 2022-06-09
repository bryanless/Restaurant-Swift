//
//  RestaurantApp.swift
//  Restaurant
//
//  Created by user on 09/06/22.
//

import SwiftUI

@main
struct RestaurantApp: App {
    @StateObject private var dataController = DataController()
    @StateObject private var mainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(mainViewModel)
        }
    }
}

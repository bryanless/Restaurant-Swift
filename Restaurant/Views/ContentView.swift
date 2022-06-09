//
//  ContentView.swift
//  Restaurant
//
//  Created by user on 09/06/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .restaurants
    
    enum Tab {
        case restaurants
        case profile
    }
    
    var body: some View {
        TabView {
            RestaurantList()
                .tabItem {
                    Label("Restaurants", systemImage: "fork.knife")
                }
                .tag(Tab.restaurants)
            
            Profile()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(Tab.profile)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(MainViewModel())
    }
}

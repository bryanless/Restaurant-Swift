//
//  RestaurantList.swift
//  Restaurant
//
//  Created by user on 09/06/22.
//

import SwiftUI

struct RestaurantList: View {
    @EnvironmentObject var viewModel: MainViewModel
    @State var showingFilter: Bool = false
    @State var selectedCity: City = .all
    @State var searchText: String = ""
    
    private var filteredRestaurants: [RestaurantBrief] {
        viewModel.restaurants.filter({
            (selectedCity == .all || $0.city.lowercased() == selectedCity.rawValue)
            && (searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText))
        })
    }
    
    enum City: String, CaseIterable, Identifiable {
        case all
        case aceh
        case bali
        case balikpapan
        case bandung
        case gorontalo
        case malang
        case medan
        case surabaya
        case ternate
        
        var id: Self { self }
    }
    
    var body: some View {
        NavigationView {
            if (viewModel.restaurants.isEmpty) {
                ProgressView()
            } else {
                List {
                    ForEach (filteredRestaurants) { restaurant in
                        NavigationLink {
                            RestaurantDetail(id: restaurant.id)
                        } label: {
                            RestaurantRow(restaurant: restaurant)
                        }
                        .tag(restaurant.id)
                    }
                }
                .navigationTitle("Restaurants")
                .searchable(text: $searchText, prompt: "Search a character")
                .toolbar {
                    Button {
                        showingFilter.toggle()
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
                .sheet(isPresented: $showingFilter) {
                    RestaurantFilter(showingFilter: $showingFilter, selectedCity: $selectedCity)
                }
            }
        }
    }
}

struct RestaurantList_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantList()
            .environmentObject(MainViewModel())
    }
}

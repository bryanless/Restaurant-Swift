//
//  RestaurantList.swift
//  Restaurant
//
//  Created by user on 09/06/22.
//

import SwiftUI

struct RestaurantList: View {
    @EnvironmentObject var viewModel: MainViewModel
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
                VStack (spacing: 0) {
                    SearchBar(searchText: $searchText)
                        .padding()
                    
                    List {
                        ForEach (filteredRestaurants) { restaurant in
                            NavigationLink(
                                destination: RestaurantDetail(id: restaurant.id)
                            ) {
                                RestaurantRow(restaurant: restaurant)
                            }
                            .tag(restaurant.id)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("Restaurants")
                    .toolbar {
                        Picker(selection: $selectedCity, label: Label("Filter", systemImage:  "line.horizontal.3.decrease.circle")
                                .font(.system(size: 22))) {
                            ForEach(City.allCases) { city in
                                Text(city.rawValue.capitalized)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                }
                }
            }
        }
    }
}

struct RestaurantList_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantList()
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(MainViewModel())
    }
}

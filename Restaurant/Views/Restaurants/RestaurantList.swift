//
//  RestaurantList.swift
//  Restaurant
//
//  Created by user on 09/06/22.
//

import SwiftUI

struct RestaurantList: View {
    @StateObject private var viewModel: RestaurantListViewModel = RestaurantListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach (viewModel.restaurants) { restaurant in
                    Text(restaurant.name)
                }
            }
            .navigationTitle("Restaurants")
        }
    }
}

struct RestaurantList_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantList()
    }
}

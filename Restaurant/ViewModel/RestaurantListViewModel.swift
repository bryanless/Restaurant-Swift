//
//  RestaurantListViewModel.swift
//  Restaurant
//
//  Created by user on 09/06/22.
//

import Foundation
import SwiftUI

class RestaurantListViewModel: ObservableObject {
    @Published var restaurants: [RestaurantBrief] = []
    
    init() {
        fetch()
    }
    
    private func fetch() {
        // MARK: Get list of restaurant
        RestaurantApi().getRestaurants { response in
            self.restaurants = response.restaurants
        }
    }
}

//
//  RestaurantListViewModel.swift
//  Restaurant
//
//  Created by user on 09/06/22.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var restaurants: [RestaurantBrief] = []
    @Published var restaurantImages: [String: Image] = [:]
    
    init() {
        fetch()
    }
    
    private func fetch() {
        // MARK: Get list of restaurant
        RestaurantApi().getRestaurants { response in
            self.restaurants = response.restaurants
            
            for restaurant in response.restaurants {
                let pictureId = restaurant.pictureId
                
                RestaurantApi().getRestaurantImageSmall(id: pictureId, completion: { image in
                    self.restaurantImages[pictureId] = image
                })
            }
        }
    }
}

//
//  RestaurantDetailViewModel.swift
//  Restaurant
//
//  Created by user on 10/06/22.
//

import Foundation
import SwiftUI
import CoreData

class RestaurantDetailViewModel: ObservableObject {
    @Published var restaurant: Restaurant = Restaurant()
    @Published var isFavorite: Bool = false
    
    func fetch(id: String, moc: NSManagedObjectContext, isLoading: @escaping (Bool) -> ()) {
        // MARK: Get restaurant
        RestaurantApi().getRestaurantDetail(id, completion: { response in
            self.restaurant = response.restaurant
            
            isLoading(false)
        })
        
        // MARK: Get favorite status
        let fetchFavorites: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        fetchFavorites.predicate = NSPredicate(format: "id = %@", id)
        
        if let results = try? moc.fetch(fetchFavorites) {
            if results.count != 0 {
                // Data exists
                if let favorite = results.first {
                    self.isFavorite = favorite.isFavorite
                }
            }
        }
    }
}

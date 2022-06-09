//
//  Restaurants.swift
//  Restaurant
//
//  Created by user on 09/06/22.
//

import Foundation

// MARK: - Restaurants
struct Restaurants: Codable, Identifiable {
    let id = UUID()
    var error: Bool = false
    var message: String = ""
    var count: Int = 0
    var restaurants: [RestaurantBrief] = []
    
    enum CodingKeys: String, CodingKey {
        case id, error, message, count, restaurants
    }
}

// MARK: - RestaurantElement
struct RestaurantBrief: Codable, Identifiable {
    var id: String = ""
    var name: String = ""
    var description: String = ""
    var pictureId: String = ""
    var city: String = ""
    var rating: Double = 0

    enum CodingKeys: String, CodingKey {
        case id, name, description, pictureId, city, rating
    }
}

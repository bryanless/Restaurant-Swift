//
//  RestaurantInfo.swift
//  Restaurant
//
//  Created by user on 09/06/22.
//

import Foundation

// MARK: - RestaurantInfo
struct RestaurantInfo: Codable {
    var error: Bool
    var message: String
    var restaurant: Restaurant
}

// MARK: - Restaurant
struct Restaurant: Codable {
    var id: String = ""
    var name: String = ""
    var description: String = ""
    var city: String = ""
    var address: String = ""
    var pictureId: String = ""
    var categories: [Category] = []
    var menus: Menus = Menus()
    var rating: Double = 0
    var customerReviews: [CustomerReview] = []
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, city, address, pictureId, categories, menus, rating, customerReviews
    }
}

// MARK: - Category
struct Category: Codable, Identifiable {
    let id = UUID()
    var name: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

// MARK: - CustomerReview
struct CustomerReview: Codable, Identifiable {
    let id = UUID()
    var name: String = ""
    var review: String = ""
    var date: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id, name, review, date
    }
}

// MARK: - Menus
struct Menus: Codable, Identifiable {
    let id = UUID()
    var foods: [Category] = []
    var drinks: [Category] = []
    
    enum CodingKeys: String, CodingKey {
        case foods, drinks
    }
}

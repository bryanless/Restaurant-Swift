//
//  RestaurantDetail.swift
//  Restaurant
//
//  Created by user on 09/06/22.
//

import Foundation

// MARK: - RestaurantDetail
struct RestaurantDetail: Codable {
    var error: Bool
    var message: String
    var restaurant: Restaurant
}

// MARK: - Restaurant
struct Restaurant: Codable {
    var id, name, restaurantDescription, city: String
    var address, pictureID: String
    var categories: [Category]
    var menus: Menus
    var rating: Double
    var customerReviews: [CustomerReview]

    enum CodingKeys: String, CodingKey {
        case id, name
        case restaurantDescription = "description"
        case city, address
        case pictureID = "pictureId"
        case categories, menus, rating, customerReviews
    }
}

// MARK: - Category
struct Category: Codable {
    var name: String
}

// MARK: - CustomerReview
struct CustomerReview: Codable {
    var name, review, date: String
}

// MARK: - Menus
struct Menus: Codable {
    var foods, drinks: [Category]
}

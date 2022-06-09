//
//  RestaurantApi.swift
//  Restaurant
//
//  Created by user on 09/06/22.
//

import Foundation

private let BASE_URL = "https://restaurant-api.dicoding.dev"

private let LIST = "list"
private let DETAIL = "detail"

struct RestaurantApi {
    private let url = URL(string: BASE_URL)
    
    // MARK: Get list of restaurant
    func getRestaurants(completion: @escaping (Restaurants) -> ()) {
        guard let url = url?.appendingPathComponent(LIST) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let response = try JSONDecoder().decode(Restaurants.self, from: data)

                DispatchQueue.main.async {
                    completion(response)
                }
            }
            catch {
                print(error)
            }
        })
        .resume()
    }
    
    // MARK: Get detail of restaurant
    func getRestaurantDetail(_ id: String, completion: @escaping (RestaurantDetail) -> ()) {
        guard let url = url?.appendingPathComponent(DETAIL).appendingPathComponent(id) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let response = try JSONDecoder().decode(RestaurantDetail.self, from: data)

                DispatchQueue.main.async {
                    completion(response)
                }
            }
            catch {
                print(error)
            }
        })
        .resume()
    }
}

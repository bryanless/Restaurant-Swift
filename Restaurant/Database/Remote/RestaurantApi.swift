//
//  RestaurantApi.swift
//  Restaurant
//
//  Created by user on 09/06/22.
//

import Foundation
import SwiftUI

private let BASE_URL = "https://restaurant-api.dicoding.dev"

private let JPEG_MIME_TYPE = "image/jpeg"

private let LIST = "list"
private let DETAIL = "detail"
private let IMAGES = "images"

private let MEDIUM = "medium"

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
    func getRestaurantDetail(_ id: String, completion: @escaping (RestaurantInfo) -> ()) {
        guard let url = url?.appendingPathComponent(DETAIL).appendingPathComponent(id) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let response = try JSONDecoder().decode(RestaurantInfo.self, from: data)

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
    
    // MARK: Get restaurant's small image
    func getRestaurantImageSmall(id: String, completion: @escaping (Image) -> ()) {
        guard let url = url?.appendingPathComponent(IMAGES).appendingPathComponent(MEDIUM).appendingPathComponent(id) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            if (response?.mimeType != JPEG_MIME_TYPE) {
                // TODO: Add image placeholder
                let image = Image("image_placeholder")

                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                do {
                    guard let uiImage = UIImage(data: data) else {
                        return
                    }
                    
                    let image = Image(uiImage: uiImage)
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        })
        .resume()
    }
}

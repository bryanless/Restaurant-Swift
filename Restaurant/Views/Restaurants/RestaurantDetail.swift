//
//  RestaurantDetail.swift
//  Restaurant
//
//  Created by user on 10/06/22.
//

import SwiftUI

struct RestaurantDetail: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var viewModel = RestaurantDetailViewModel()
    var id: String
    @State private var isLoading: Bool = true
    
    var body: some View {
        let restaurant = viewModel.restaurant
        
        ScrollView {
            if isLoading {
                ProgressView()
            } else {
                VStack {
                    mainViewModel.restaurantImages[restaurant.pictureId]?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    VStack {
                        VStack (alignment: .leading, spacing: 15) {
                            VStack (alignment: .leading) {
                                HStack {
                                    Text(restaurant.name)
                                        .font(.title)
                                    
                                    FavoriteButton(id: id, isSet: $viewModel.isFavorite)
                                }
                                
                                HStack {
                                    Text(restaurant.address)
                                    Spacer()
                                    Text(restaurant.city)
                                }
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            }
                            
                            HStack (spacing: 2) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                
                                Text(restaurant.rating.description)
                            }
                            
                            HStack {
                                ForEach (restaurant.categories) { category in
                                    Text(category.name)
                                }
                            }
                        }
                        
                        Divider()
                        
                        VStack (alignment: .leading, spacing: 5) {
                            Text("About \(restaurant.name)")
                                .font(.title2)
                            
                            Text(restaurant.description)
                        }
                        
                        Divider()
                        
                        VStack (alignment: .leading, spacing: 10) {
                            Text("Menu")
                                .font(.title2)
                            
                            VStack (alignment: .leading) {
                                Text("Foods")
                                    .font(.title3)
                                
                                ForEach (restaurant.menus.foods) { food in
                                    Text("\u{2022} \(food.name)")
                                }
                            }
                            
                            VStack (alignment: .leading) {
                                Text("Drinks")
                                    .font(.title3)
                                
                                ForEach (restaurant.menus.drinks) { drink in
                                    Text("\u{2022} \(drink.name)")
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding()
                }
                .navigationTitle(restaurant.name)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onAppear {
            viewModel.fetch(id: id, moc: moc) { isLoading  in
                self.isLoading = isLoading
            }
        }
    }
}

struct RestaurantDetail_Previews: PreviewProvider {
    static var viewModel = MainViewModel()
    
    static var previews: some View {
        RestaurantDetail(id: viewModel.restaurants.first?.id ?? "rqdv5juczeskfw1e867")
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(viewModel)
    }
}

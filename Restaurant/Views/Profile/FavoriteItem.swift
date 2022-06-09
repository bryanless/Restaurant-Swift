//
//  FavoriteItem.swift
//  Restaurant
//
//  Created by user on 10/06/22.
//

import SwiftUI

struct FavoriteItem: View {
    @EnvironmentObject var viewModel: MainViewModel
    @State var id: String
    
    var body: some View {
        let restaurant = viewModel.restaurants.first(where: { $0.id == id }) ?? RestaurantBrief()
        
        VStack (alignment: .leading, spacing: 0) {
            viewModel.restaurantImages[restaurant.pictureId]?
                .resizable()
                .aspectRatio(3/2, contentMode: .fill)
            
            Text(restaurant.name)
                .font(.title3)
                .frame(height: 50)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: .gray, radius: 2, x: 0, y: 3)
    }
}

struct FavoriteItem_Previews: PreviewProvider {
    static var viewModel = MainViewModel()
    
    static var previews: some View {
        FavoriteItem(id: viewModel.restaurants.first?.id ?? "rqdv5juczeskfw1e867")
            .environmentObject(viewModel)
    }
}

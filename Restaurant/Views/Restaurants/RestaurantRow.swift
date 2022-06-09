//
//  RestaurantRow.swift
//  Restaurant
//
//  Created by user on 10/06/22.
//

import SwiftUI

struct RestaurantRow: View {
    @EnvironmentObject var viewModel: MainViewModel
    @State var restaurant: RestaurantBrief
    
    var body: some View {
        HStack {
            viewModel.restaurantImages[restaurant.pictureId]?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 105, height: 70)
                .cornerRadius(5)
            
            VStack (alignment: .leading) {
                Text(restaurant.name)
                    .font(.headline)
                
                Text(restaurant.city)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                HStack (spacing: 2) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text(restaurant.rating.description)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct RestaurantRow_Previews: PreviewProvider {
    static var viewModel = MainViewModel()
    
    static var previews: some View {
        RestaurantRow(restaurant: viewModel.restaurants.first ?? RestaurantBrief())
            .environmentObject(viewModel)
    }
}

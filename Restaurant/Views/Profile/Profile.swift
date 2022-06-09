//
//  Profile.swift
//  Restaurant
//
//  Created by user on 10/06/22.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)],
        predicate: NSPredicate(format: "isFavorite = true")) private var favorites: FetchedResults<Favorites>
    
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image("profile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(.black, lineWidth: 3)
                        }
                    
                    Text("Bryan")
                        .font(.title2)
                }
                .padding()
                
                VStack (alignment: .leading) {
                    Text("Favorites")
                        .font(.title)
                    
                    if (viewModel.restaurants.isEmpty) {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        if (favorites.isEmpty) {
                            HStack {
                                Spacer()
                                
                                Text("No Favorite")
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                                    .padding()
                                
                                Spacer()
                            }
                        } else {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(favorites, id: \.self) { favorite in
                                    NavigationLink(destination: RestaurantDetail(id: favorite.id ?? "")) {
                                        FavoriteItem(id: favorite.id ?? "")
                                    }
                                    .tag(favorite.id)
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .navigationTitle("Profile")
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
            .environmentObject(MainViewModel())
    }
}

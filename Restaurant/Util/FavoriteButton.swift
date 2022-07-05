//
//  FavoriteButton.swift
//  Restaurant
//
//  Created by user on 10/06/22.
//

import SwiftUI
import CoreData

struct FavoriteButton: View {
    @Environment(\.managedObjectContext) var moc
    var id: String
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
            
            let fetchFavorites: NSFetchRequest<Favorites> = Favorites.fetchRequest()
            fetchFavorites.predicate = NSPredicate(format: "id = %@", id)
            
            let results = try? moc.fetch(fetchFavorites)
            
            if results?.count == 0 {
                // New data
                let favorite = Favorites(context: moc)
                favorite.id = id
                favorite.isFavorite = isSet
            } else {
                // Data exists
                let favorite = results?.first
                favorite?.id = id
                favorite?.isFavorite = isSet
            }
            
            try? moc.save()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "heart.fill" : "heart")
                .labelStyle(IconOnlyLabelStyle())
                .foregroundColor(isSet ? .red : .gray)
                .font(.system(size: 24))
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(id: "", isSet: .constant(true))
            .environment(\.managedObjectContext, DataController().container.viewContext)
    }
}

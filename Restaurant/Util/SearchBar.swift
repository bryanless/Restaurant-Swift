//
//  SearchBar.swift
//  Restaurant
//
//  Created by Bryan on 06/07/22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Search a restaurant", text: $searchText)
                .disableAutocorrection(true)
            
            Button {
                searchText = ""
            } label: {
                Label("Cancel", systemImage: "xmark.circle.fill")
                    .labelStyle(IconOnlyLabelStyle())
                    .opacity(searchText.isEmpty ? 0 : 1)
            }
        }
        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
    }
}

//
//  RestaurantFilter.swift
//  Restaurant
//
//  Created by user on 10/06/22.
//

import SwiftUI

struct RestaurantFilter: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showingFilter: Bool
    @Binding var selectedCity: RestaurantList.City
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Cities", selection: $selectedCity) {
                    ForEach(RestaurantList.City.allCases) { city in
                        Text(city.rawValue.capitalized)
                    }
                }
                .pickerStyle(.inline)
            }
            .navigationTitle("Filter Restaurant")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        selectedCity = .all
                    } label: {
                        Text("Reset")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
    }
}

struct RestaurantFilter_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantFilter(showingFilter: .constant(true), selectedCity: .constant(.all))
    }
}

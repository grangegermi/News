//
//  FavoritesView.swift
//  News
//
//  Created by Даша Волошина on 17.05.25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var dataService: DataServices
    
    var body: some View {
        if dataService.favorites.isEmpty {
            EmptyViewApp(item: .favorites)
        } else {
            VStack {
                ForEach(dataService.favorites, id: \.id) { fav in
                    CellFavorites(favorites: fav)
                }
            }
        }
    }
}


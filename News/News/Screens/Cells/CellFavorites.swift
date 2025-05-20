//
//  CellFavorites.swift
//  News
//
//  Created by Даша Волошина on 18.05.25.
//

import SwiftUI

struct CellFavorites: View {
    @EnvironmentObject var dataService: DataServices
    @EnvironmentObject var alertManager: AlertManager
    
    @State private var showAlert = false
    
    let favorites: FavoriteItem
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: favorites.image ?? ""), content: { image in image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(Sizes.cornerRadiusSmall)
            }, placeholder: {
                ProgressView()
                    .frame(width: Sizes.imageNewsWidth, height: Sizes.imageNewsHeight)
            })
            .padding()
            VStack(alignment: .leading){
                HStack(alignment: .top){
                    if let urlString = favorites.url, let url = URL(string: urlString) {
                        Link(destination: url) {
                            VStack(alignment: .leading){
                                Text(favorites.title ?? "")
                                    .lineLimit(1)
                                    .foregroundColor(.blackApp)
                                    .font(Font.system(size: Sizes.sizeFontStandart))
                                    .fontWeight(.medium)
                                Text(favorites.abstract ?? "")
                                    .lineLimit(1)
                                    .font(Font.system(size: Sizes.sizeFont))
                                    .foregroundColor(.greyApp)
                                    .fontWeight(.regular)
                            }
                        }
                    }
                    Spacer()
                    let isFavorite = dataService.favorites.contains(where: { $0.id == favorites.id})
                    MenuView(action: [
                        .favorites: {
                            if isFavorite{
                                dataService.removeNews(id: favorites.id ?? "")
                            }
                        },
                        .blocked: {
                            alertManager.showCustomAlert(
                                title: "Do you want to block?",
                                message: "Confirm to hide this news source",
                                item: .blockButton,
                                onBlock: {
                                    dataService.addNews(id: favorites.id ?? "",
                                                        title: favorites.title ?? "",
                                                        url: favorites.url ?? "",
                                                        image: favorites.image ?? "",
                                                        isBlocked: true,
                                                        publishedDate: favorites.publishedDate ?? "",
                                                        section: favorites.section ?? "",
                                                        abstract: favorites.abstract ?? "")
                                    dataService.removeNews(id: favorites.id ?? "")
                                },
                                onCancel: {}
                                
                            )
                        }
                    ], isFav: isFavorite)
                }
                .padding(.trailing, Spacing.standart)
                Text((favorites.section ?? "") + "•" + (favorites.publishedDate ?? ""))
                    .foregroundColor(.greyApp)
                    .font(Font.system(size: Sizes.sizeFont))
            }
            
        }
        .background(Color.whiteApp)
        .cornerRadius(Sizes.cornerRadiusStandart)
        .frame(height: Sizes.cellHeight)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, Spacing.standart)
        .padding(.vertical, Spacing.standart)
    }
}




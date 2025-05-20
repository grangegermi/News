//
//  CellBlocked.swift
//  News
//
//  Created by Даша Волошина on 18.05.25.
//

import SwiftUI

struct CellBlocked: View {
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
                    Menu {
                        Button(role: .destructive) {
                            alertManager.showCustomAlert(
                                title: "Do you want to unblock?",
                                message: "Confirm to hide this news source",
                                item: .unblockButton,
                                onBlock: {
                                    dataService.removeBlockedNews(id: favorites.id ?? "")
                                },
                                
                                onCancel: {}
                            )
                        } label: {
                            Label("Unblock", systemImage: "lock.open")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .frame(width: Sizes.systemImage, height: Sizes.systemImage)
                            .foregroundColor(.greyApp)
                    }
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



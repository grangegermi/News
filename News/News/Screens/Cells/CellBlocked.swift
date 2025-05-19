//
//  CellBlocked.swift
//  News
//
//  Created by Даша Волошина on 18.05.25.
//

import SwiftUI

struct CellBlocked: View {
    @EnvironmentObject var dataService: DataServices
    let favorites: FavoriteItem
    @State private var showAlert = false
    
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
                    Link(destination: URL(string: favorites.url ?? "")!) {
                        VStack(alignment: .leading){
                            Text(favorites.title ?? "")
                                .lineLimit(1)
                                .foregroundColor(.blackApp)
                                .font(Font.system(size: 17))
                                .fontWeight(.medium)
                            Text(favorites.abstract ?? "")
                                .lineLimit(1)
                                .font(Font.system(size: 15))
                                .foregroundColor(.greyApp)
                                .fontWeight(.regular)
                        }
                        Spacer()
                        Menu {
                            Button(role: .destructive) {
                                showAlert = true
                            } label: {
                                Label("Unblock", systemImage: "lock.open")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .frame(width: Sizes.systemImage, height: Sizes.systemImage)
                                .foregroundColor(.greyApp)
                        }
                        .alert("Do you want to Ulock?",
                               isPresented: $showAlert,
                               actions: {
                            Button("Unlock", role: .destructive) {
                                dataService.removeBlockedNews(id: favorites.id ?? "")
                                print(dataService.blocked.count)
                            }
                            Button("Cancel", role: .cancel) { }
                        },
                               message: {
                            Text("Confirm to hide this news source")
                        })
                        .padding(.trailing, Spacing.standart)
                    }
                }
                Text((favorites.section ?? "") + "•" + (favorites.publishedDate ?? ""))
                    .foregroundColor(.greyApp)
                    .font(Font.system(size: 15))
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



//
//  CellNews.swift
//  News
//
//  Created by Даша Волошина on 17.05.25.
//

import SwiftUI

struct CellNews: View {
    @EnvironmentObject var dataService: DataServices
    let new: Result
    @State private var showAlert = false
    
    var body: some View {
        ZStack{
            
            HStack{
                AsyncImage(url: URL(string: new.media?.first?.mediaMetaData?.first?.url ?? ""), content: { image in image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(Sizes.cornerRadiusSmall)
                    //                    .clipped()
                }, placeholder: {
                    ProgressView()
                        .frame(width: Sizes.imageNewsWidth, height: Sizes.imageNewsHeight)
                })
                .padding()
                
                VStack(alignment: .leading){
                    
                    HStack(alignment: .top){
                        //                        Link(destination: URL(string: new.url ?? "")!) {
                        VStack(alignment: .leading){
                            Text(new.title ?? "")
                                .lineLimit(1)
                                .foregroundColor(.blackApp)
                                .font(Font.system(size: 17))
                                .fontWeight(.medium)
                            Text(new.abstract ?? "")
                                .lineLimit(1)
                                .font(Font.system(size: 15))
                                .foregroundColor(.greyApp)
                                .fontWeight(.regular)
                        }
                        Spacer()
                        
                        let isFavorite = dataService.favorites.contains(where: { $0.id == String(new.id ?? 0)})
                        MenuView(action: [
                            .favorites: {
                                if !isFavorite {
                                    dataService.addNews(id: String(new.id ?? 0),
                                                        title: new.title ?? "",
                                                        url: new.url ?? "",
                                                        image: new.media?.first?.mediaMetaData?.first?.url ?? "",
                                                        isBlocked: false,
                                                        publishedDate: new.formattedPublishedDate,
                                                        section: new.section ?? "",
                                                        abstract: new.abstract ?? "")
                                }else {
                                    dataService.removeNews(id: String(new.id ?? 0))
                                    
                                }
                            },
                            .blocked: {
                                showAlert = true
                            }
                        ], isFav:isFavorite
                        )
                        .alert("Do you want to block?",
                               isPresented: $showAlert,
                               actions: {
                            Button("Block", role: .destructive) {
                                dataService.addNews(
                                    id: String(new.id ?? 0),
                                    title: new.title ?? "",
                                    url: new.url ?? "",
                                    image: new.media?.first?.mediaMetaData?.first?.url ?? "",
                                    isBlocked: true,
                                    publishedDate: new.formattedPublishedDate,
                                    section: new.section ?? "",
                                    abstract: new.abstract ?? ""
                                )}
                            Button("Cancel", role: .cancel) { }
                        },
                               message: {
                            Text("Confirm to hide this news source")
                        })
                        
                        .padding(.trailing, Spacing.standart)
                    }
                    Text((new.section ?? "") + "•" + new.formattedPublishedDate)
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
}

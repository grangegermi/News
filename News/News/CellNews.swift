//
//  CellNews.swift
//  News
//
//  Created by Даша Волошина on 17.05.25.
//

import SwiftUI

struct CellNews: View {
    let new: Result
    
    var body: some View {
        
        Link(destination: URL(string: new.url ?? "")!) {
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
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .frame(width: Sizes.systemImage, height: Sizes.systemImage)
                                .foregroundColor(.greyApp)
                        }
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


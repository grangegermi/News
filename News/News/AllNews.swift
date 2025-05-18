//
//  AllNews.swift
//  News
//
//  Created by Даша Волошина on 17.05.25.
//

import SwiftUI

struct AllNews: View {
    @EnvironmentObject var network: NetworkService
    @EnvironmentObject var dataService: DataServices
    var body: some View {
        VStack{
            if network.news?.results?.isEmpty == true {
                EmptyViewApp(item: .all)
                Button {
                } label: {
                    ZStack{
                        Text("Refresh")
                            .foregroundColor(.whiteApp)
                            .font(Font.system(size: 17))
                            .fontWeight(.medium)
                        HStack{
                            Spacer()
                            Image(systemName: "arrow.clockwise")
                                .frame(width: Sizes.systemImage, height: Sizes.systemImage)
                                .foregroundColor(.whiteApp)
                        }
                        .padding(.horizontal, Spacing.standart)
                    }
                  
                    .frame(height: Sizes.buttonHeight)
                    .background(Color.blueApp)
                    .cornerRadius(Sizes.cornerRadiusSmall)
                    .padding(Spacing.standart)
                }
            } else {
                if let news = network.news?.results{
                    ForEach(Array(news.enumerated()), id: \.1.id) { index, new in
                        CellNews(new: new)
                        
                        if (index + 1) % 2 == 0,
                           let blocks = network.block?.results,
                           (index / 2) < blocks.count {
                            CellBlocks(block: blocks[index / 2])
                        }
                    }
                }
            }
        }
    }
}


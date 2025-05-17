//
//  AllNews.swift
//  News
//
//  Created by Даша Волошина on 17.05.25.
//

import SwiftUI

struct AllNews: View {
    @EnvironmentObject var network: NetworkService
    var body: some View {
        VStack{
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

#Preview {
    AllNews()
}

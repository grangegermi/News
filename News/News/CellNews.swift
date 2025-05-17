//
//  CellNews.swift
//  News
//
//  Created by Даша Волошина on 17.05.25.
//

import SwiftUI

struct CellNews: View {
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: "https://static01.nyt.com/images/2025/04/15/multimedia/14nat-harvard-letter-sldf/15nat-university-weath-jflv-mediumThreeByTwo210.jpg"), content: { image in image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(Sizes.cornerRadiusSmall)
            }, placeholder: {
                ProgressView()
                    .frame(width: Sizes.imageNewsHeight)
            })
            .padding()
           
            VStack(alignment: .leading){
                Text("fkmvk")
                    .lineLimit(1)
                    .foregroundColor(.blackApp)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.bottom)
                Text("nfvkvk")
                    .lineLimit(1)
                    .foregroundColor(.greyApp)
                    .padding(.bottom)
                HStack{
                    Text("Culture")
                        .foregroundColor(.greyApp)
                    
                    Text("• 24.April 2034")
                        .foregroundColor(.greyApp)
                }
            }
            .padding()
      
            Button {
                
            } label: {
                Image(systemName: "ellipsis.circle")
                    .frame(width: Sizes.systemImage, height: Sizes.systemImage)
                    .foregroundColor(.greyApp)
            }
            .padding()
        }
        .background(Color.whiteApp)
        .cornerRadius(Sizes.cornerRadiusStandart)
        .frame(height: Sizes.cellHeight)
        .frame(maxWidth: .infinity)
//        .padding()
    }
}

#Preview {
    CellNews()
}

//
//  CellBlocks.swift
//  News
//
//  Created by Даша Волошина on 18.05.25.
//

import Foundation
import SwiftUI

struct CellBlocks: View {
    let block: ResultBlocks
    @State var showAlert = false
    
    var body: some View {
        VStack{
            Image(systemName: block.titleSymbol ?? "")
                .frame(width: Sizes.systemImage, height: Sizes.systemImage)
                .foregroundColor(.blueApp)
            Text(block.title)
                .foregroundColor(.blackApp)
                .font(Font.system(size: 17))
                .fontWeight(.medium)
            Text(block.subTitle ?? "")
                .font(Font.system(size: 15))
                .foregroundColor(.greyApp)
                .fontWeight(.regular)
            Button {
            } label: {
                ZStack{
                    Text(block.buttonTitle)
                        .foregroundColor(.whiteApp)
                        .font(Font.system(size: 17))
                        .fontWeight(.medium)
                    HStack{
                        Spacer()
                        Image(systemName: block.buttonSymbol ?? "")
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
        }
        .frame(height: Sizes.cellHeightBig)
        .background(Color.whiteApp)
        .cornerRadius(Sizes.cornerRadiusStandart)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, Spacing.standart)
        .padding(.vertical, Spacing.standart)
    }
}

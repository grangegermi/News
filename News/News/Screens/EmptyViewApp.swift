//
//  EmptyViewApp.swift
//  News
//
//  Created by Даша Волошина on 18.05.25.
//

import SwiftUI

enum Empty: CaseIterable{
    case all
    case favorites
    case blocked
}

extension Empty {
    var title : String {
        switch self {
        case.all:
            return "No Results"
        case .favorites:
            return "No Favorite News"
        case .blocked:
            return "No Blocked News"
            
        }
    }
    
    var image : String {
        switch self {
        case.all:
            return "exclamationmark.circle.fill"
        case .favorites:
            return "heart.circle.fill"
        case .blocked:
            return "nosign"
            
        }
    }
    
}

struct EmptyViewApp: View {
    let item: Empty
    
    var body: some View {
        VStack{
            Image(systemName: item.image)
                .frame(width: Sizes.systemImageBig, height: Sizes.systemImage)
                .foregroundColor(.blueApp)
            Text(item.title)
                .fontWeight(.bold)
                .foregroundColor(.blackApp)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, UIScreen.main.bounds.height * 0.2 )
    }
}

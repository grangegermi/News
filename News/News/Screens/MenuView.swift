//
//  Menuview.swift
//  News
//
//  Created by Даша Волошина on 18.05.25.
//

import SwiftUI

enum ActionButton: CaseIterable, Identifiable {
    case favorites
    case blocked
    var id: Int { return hashValue }
}

extension ActionButton {
    
    func title(isFav: Bool) -> LocalizedStringKey {
        switch self {
        case .favorites:
            return isFav ? "Remove from Favorites" : "Add to Favorites"
        case .blocked:
            return "Block"
        }
    }
    
    func image(isFav: Bool) -> String {
        switch self {
        case .favorites:
            return  isFav ? "heart.slash" : "heart"
        case .blocked:
            return "nosign"
        }
    }
    
    var isDestructive: Bool {
        switch self {
        case .favorites:
            return false
        case .blocked:
            return true
        }
    }
}

struct MenuView: View {
    @EnvironmentObject var dataService: DataServices
    
    let items = ActionButton.allCases
    let action: [ActionButton:() -> Void]
    let isFav: Bool
    
    var body: some View {
        Menu {
            ForEach(items, id: \.self ) { item in
                Button(role: item.isDestructive ? .destructive : nil) {
                    action[item]?()
                } label: {
                    HStack{
                        Text(item.title(isFav: isFav))
                        Spacer()
                        Image(systemName: item.image(isFav: isFav))
                    }
                }
            }
            
        } label: {
            
            Image(systemName: "ellipsis.circle")
                .frame(width: Sizes.systemImage, height: Sizes.systemImage)
                .foregroundColor(.greyApp)
        }
    }
}


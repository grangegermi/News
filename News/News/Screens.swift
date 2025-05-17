//
//  Screens.swift
//  News
//
//  Created by Даша Волошина on 17.05.25.
//

import Foundation
import SwiftUI

enum AppScreens: String, Hashable, CaseIterable{
    case news = "All"
    case favorites = "Favorites"
    case blocked = "Blocked"
    
    var id: String {
            return String(describing: self)
        }

        static func == (lhs: AppScreens, rhs: AppScreens) -> Bool {
            return lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
}


class ViewModel: ObservableObject {
    @Published var screen = AppScreens.news
}

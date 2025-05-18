//
//  BlockedView.swift
//  News
//
//  Created by Даша Волошина on 17.05.25.
//

import SwiftUI

struct BlockedView: View {
    @EnvironmentObject var dataService: DataServices
    
    var body: some View {
        VStack{
            if dataService.blocked.isEmpty {
                Spacer()
                EmptyViewApp(item: .blocked)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            else {
                ForEach(dataService.blocked, id: \.id) {blocked in
                    CellBlocked(favorites: blocked)
                }
            }
        }
    }
}


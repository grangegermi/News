//
//  ContentView.swift
//  News
//
//  Created by Даша Волошина on 17.05.25.
//

import SwiftUI

enum NewsView: String, CaseIterable {
    case news = "All"
    case favorites = "Favorites"
    case blocked = "Blocked"
    
    var id: String{rawValue}
}

struct MainView: View {
    @StateObject var viewModel = ViewModel()
    @EnvironmentObject var network: NetworkService
    
    var body: some View {
        NavigationView {
            VStack{
                ScrollView{
                    Picker("News",  selection: $viewModel.screen) {
                        ForEach(AppScreens.allCases, id: \.self){
                            Text($0.rawValue)
                            
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    Group {
                        switch viewModel.screen {
                        case .news:
                            AllNews()
                        case .favorites:
                            FavoritesView()
                        case .blocked:
                            BlockedView()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("News")
            .navigationBarTitleDisplayMode(.large)
            .background(Color.beigeApp)
            
        }
        .task {
            do {
                try await network.getNews()
                try await network.getBlocks()
            } catch {
                
            }
        }
        .onAppear{
           
            let appearance = UINavigationBarAppearance()
            appearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor(Color.blackApp)
            ]
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor(Color.blackApp)
            ]
            UINavigationBar.appearance().standardAppearance = appearance
        }
     
    }
}

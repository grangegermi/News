//
//  ContentView.swift
//  News
//
//  Created by Даша Волошина on 17.05.25.
//

import SwiftUI

//enum NewsView: String, CaseIterable {
//    case news = "All"
//    case favorites = "Favorites"
//    case blocked = "Blocked"
//    
//    var id: String{rawValue}
//}

struct MainView: View {
    @StateObject var viewModel = ViewModel()
    @EnvironmentObject var network: NetworkService
    @State var isLoanding = false
    @State var showAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack{
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
                                AllNews(loanding: $isLoanding)
                            case .favorites:
                                FavoritesView()
                            case .blocked:
                                BlockedView()
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
                        let networkError = ErrorApp.map(error: error)
                        errorMessage = networkError.errorMessage
                        showAlert = true
                    }
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            if isLoanding{
                ZStack{
                    Color.black.opacity(0.3)
                    ProgressView()
                        .padding()
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .background(.ultraThinMaterial)
            }
            if showAlert {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .background(.ultraThinMaterial)
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
    }
}

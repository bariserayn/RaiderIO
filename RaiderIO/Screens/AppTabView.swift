//
//  ContentView.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            SearchCharacterView()
                .tabItem { Label("Search", systemImage: SFSymbol.search) }
            CharacterListView(viewModel: CharacterListViewModelImpl(coreDataManager: CoreDataManager(), service: WebServiceImpl()))
                .tabItem { Label("Favorites", systemImage: SFSymbol.person) }
//            LeaderboardListView()
//                .tabItem { Label("Leaderboard", systemImage: SFSymbol.starCircle) } //TODO: Leaderbord List View
        }
        .accentColor(.brandPrimary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}

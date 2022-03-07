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
            CharacterListView()
                .tabItem { Label("Favorites", systemImage: SFSymbol.person) }
            LeaderboardListView()
                .tabItem { Label("Leaderboard", systemImage: SFSymbol.star) }
        }
        .accentColor(.brandPrimary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}

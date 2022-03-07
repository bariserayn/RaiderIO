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
            CharacterListView()
                .tabItem { Label("Character", systemImage: "person.circle") }
            LeaderboardListView()
                .tabItem { Label("Leaderboard", systemImage: "star.circle") }
        }
        .accentColor(.brandPrimary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}

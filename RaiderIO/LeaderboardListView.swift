//
//  LeaderboardListView.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import SwiftUI

struct LeaderboardListView: View {
    var body: some View {
        NavigationView {
            Text("Top Runs View")
                .navigationTitle("Top Runs")
        }
    }
}

struct LeaderboardListView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardListView()
    }
}

//
//  CharacterListView.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import SwiftUI

struct CharacterListView: View {
    var body: some View {
        NavigationView {
            Text("Character List View")
                .navigationTitle("Character List")
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}

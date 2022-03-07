//
//  CharacterDetailView.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                print(character)
            }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(character: MockData.character)
    }
}

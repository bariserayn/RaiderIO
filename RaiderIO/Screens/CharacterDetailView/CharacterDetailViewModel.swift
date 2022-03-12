//
//  CharacterDetailViewModel.swift
//  RaiderIO
//
//  Created by baris on 9.03.2022.
//

import Foundation

protocol CharacterDetailViewModel {
    func saveCharacterData() async
}

@MainActor final class CharacterDetailViewModelImpl: ObservableObject, CharacterDetailViewModel {
    @Published var isShowingDetail = false
    @Published var selectedDungeon: MythicPlusRun?
    
    var character: Character
    
    init(character: Character) {
        self.character = character
    }

    func saveCharacterData() async {
        print("\(character) saving...")
    }
}

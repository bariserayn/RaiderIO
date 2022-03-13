//
//  CharacterDetailViewModel.swift
//  RaiderIO
//
//  Created by baris on 9.03.2022.
//

import Foundation

protocol CharacterDetailViewModel {
    func saveCharacter() async
}

@MainActor final class CharacterDetailViewModelImpl: ObservableObject, CharacterDetailViewModel {
    @Published var isShowingDetail = false
    @Published var selectedDungeon: MythicPlusRun?
    @Published var savedCharacters: [SavedCharacter] = []

    var character: Character
    let coreDataManager: CoreDataManager
    
    init(character: Character, coreDataManager: CoreDataManager) {
        self.character = character
        self.coreDataManager = coreDataManager
    }

    func saveCharacter() async {
        coreDataManager.saveCharacter(character: character)
    }
    
    func getAllCharacters()  {
        savedCharacters = coreDataManager.getAllCharacters()
    }
    
    func checkIsCharacterSaved() -> Bool {
        coreDataManager.checkIfCharacterExists(name: character.name)
    }
    
    func deleteCharacter() {
        for savedCharacter in savedCharacters {
            if savedCharacter.name == character.name {
                coreDataManager.deleteCharacter(savedCharacter: savedCharacter)
            }
        }
    }
}

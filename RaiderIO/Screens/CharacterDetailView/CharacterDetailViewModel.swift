//
//  CharacterDetailViewModel.swift
//  RaiderIO
//
//  Created by baris on 9.03.2022.
//

import Foundation

protocol CharacterDetailViewModel {
    func saveCharacterData(character: Character) async
}

@MainActor final class CharacterDetailViewImpl: ObservableObject, CharacterDetailViewModel {
    @Published var character: Character?
    
    func saveCharacterData(character: Character) async {
        print("\(character) saving...")
    }
}

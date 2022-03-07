//
//  SearchCharacterViewModelImpl.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import Foundation

protocol SearchCharacterViewModel {
    func getCharacterData()
}

class SearchCharacterViewModelImpl: ObservableObject, SearchCharacterViewModel {
    @Published var region = "EU"
    @Published var characterName = ""
    @Published var realm = ""
        
    func isValidInput() -> Bool {
        guard !characterName.isEmpty,
              !realm.isEmpty else { return false }
        return true
    }
    
    func getCharacterData() {
        
    }
}

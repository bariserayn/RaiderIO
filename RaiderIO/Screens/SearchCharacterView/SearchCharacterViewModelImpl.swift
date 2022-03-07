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

final class SearchCharacterViewModelImpl: ObservableObject, SearchCharacterViewModel {
    @Published var region = "EU"
    @Published var characterName = ""
    @Published var realm = ""
    @Published var alertItem: AlertItem?
    
    func isValidInput() -> Bool {
        guard !characterName.isEmpty,
              !realm.isEmpty else { return false }
        return true
    }
    
    func getCharacterData() {
        guard isValidInput() else {
            alertItem = AlertContext.invalidSearch
            return
        }
        
        
    }
}

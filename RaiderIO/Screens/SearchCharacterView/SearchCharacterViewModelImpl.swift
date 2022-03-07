//
//  SearchCharacterViewModelImpl.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import Foundation

protocol SearchCharacterViewModel {
    func getCharacterData() async
}

final class SearchCharacterViewModelImpl: ObservableObject, SearchCharacterViewModel {
    private let service: WebService
    
    init(service: WebService) {
        self.service = service
    }
    
    @Published var region = "EU"
    @Published var characterName = ""
    @Published var realm = ""
    @Published var alertItem: AlertItem?
    
    func isValidInput() -> Bool {
        guard !characterName.isEmpty,
              !realm.isEmpty else { return false }
        return true
    }
    
    func getCharacterData() async {
        guard isValidInput() else {
            alertItem = AlertContext.invalidSearch
            return
        }
        
        do {
            let character = try await service.getCharacterRequest(from: .getCharacter, region: region, realm: realm, name: characterName)
            print(character)
        } catch(let error) {
            let riError = error as! RIError
            DispatchQueue.main.async {
                switch riError {
                    case .invalidSearch:
                        self.alertItem = AlertContext.invalidSearch
                    case .invalidInput:
                        self.alertItem = AlertContext.invalidInput
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                }
            }
        }
    }
}

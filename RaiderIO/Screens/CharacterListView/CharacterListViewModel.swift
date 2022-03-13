//
//  CharacterListViewModel.swift
//  RaiderIO
//
//  Created by baris on 13.03.2022.
//

import Foundation

protocol CharacterListViewModel {
    func getAllCharacters() async
}

@MainActor final class CharacterListViewModelImpl: ObservableObject, CharacterListViewModel {
    @Published var alertItem: AlertItem?
    @Published var character: Character?
    @Published var isLoading = false
    @Published var savedCharacters: [SavedCharacter] = []
    @Published var isShowingDetail = false

    private let coreDataManager: CoreDataManager
    private let service: WebService
    
    init(coreDataManager: CoreDataManager, service: WebService) {
        self.coreDataManager = coreDataManager
        self.service = service
    }
    
    func getAllCharacters() async {
        savedCharacters = coreDataManager.getAllCharacters()
    }
    
    func deleteCharacter(savedCharacter: SavedCharacter) {
        coreDataManager.deleteCharacter(savedCharacter: savedCharacter)
    }
    
    func getCharacterData(region: String, realm: String, name: String) async {
        showLoadingView()
        
        Task {
            do {
                character = try await service.getCharacterRequest(from: .getCharacter, region: region, realm: realm, name: name)
                isShowingDetail = true
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
            hideLoadingView()
        }
    }

    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
}

//
//  SearchCharacterViewModelImpl.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import SwiftUI

protocol SearchCharacterViewModel {
    func getCharacterData() async
}

@MainActor final class SearchCharacterViewModelImpl: ObservableObject, SearchCharacterViewModel {
    @Published var region = "EU"
    @Published var characterName = ""
    @Published var realm = ""
    @Published var alertItem: AlertItem?
    @Published var character: Character?
    @Published var isLoading = false
    @Published var isShowingDetail = false

    private let service: WebService
    
    init(service: WebService) {
        self.service = service
    }
    
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
        
        showLoadingView()
        
        Task {
            do {
                character = try await service.getCharacterRequest(from: .getCharacter, region: region, realm: realm, name: characterName)
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

//
//  WebService.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import Foundation

protocol WebService {
    func getCharacterRequest(from endpoint: RaiderAPI, region: String, realm: String, name: String) async throws -> Character
}

class WebServiceImpl: WebService {
    
    let decoder = JSONDecoder()

    func getCharacterRequest(from endpoint: RaiderAPI, region: String, realm: String, name: String) async throws -> Character {
        let fields = "covenant,guild,raid_progression,gear,mythic_plus_scores_by_season:current,mythic_plus_best_runs:timed"
        let urlWithPath = endpoint.url + "?region=\(region)&realm=\(realm)&name=\(name)&fields=\(fields)"

        guard let _ = URL(string: urlWithPath) else {
            throw RIError.invalidResponse
        }
        
        let urlRequest = URLRequest(url: URL(string: urlWithPath)!)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw RIError.invalidInput
        }
                
        do {
            let character = try decoder.decode(Character.self, from: data)
            return character
        } catch {
            throw RIError.invalidData
        }
    }
}

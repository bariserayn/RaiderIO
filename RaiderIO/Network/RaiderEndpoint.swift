//
//  RaiderEndpoint.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import Foundation

protocol APIBuilder {
    var baseUrl: String { get }
    var path: String { get }
    var url: String { get }
}

enum RaiderAPI {
    case getCharacter
    case getGuild
}

extension RaiderAPI: APIBuilder {
    var baseUrl: String {
        return "https://raider.io/api/v1"
    }
    
    var path: String {
        switch self {
            case .getCharacter:
                return "/characters/profile"
            case .getGuild:
                return "/guilds/profile"
        }
    }
    
    var url: String {
        return self.baseUrl + self.path
    }
}

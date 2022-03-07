//
//  Character.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import Foundation

struct Character: Codable {
    let name: String
    let race: String
    let rClass: String
    let spec: String
    let specRole: String
    let faction: String
    let achievementPoints: Int
    let thumbnailURL: String
    let region: String
    let realm: String
    let profileURL: String

    enum CodingKeys: String, CodingKey {
        case name
        case race
        case rClass = "class"
        case spec = "active_spec_name"
        case specRole = "active_spec_role"
        case faction
        case achievementPoints = "achievement_points"
        case thumbnailURL = "thumbnail_url"
        case region
        case realm
        case profileURL = "profile_url"
    }
}

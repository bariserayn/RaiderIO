//
//  MockData.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import Foundation

struct MockData {
    static var character: Character {
        let character = Character(name: "Lochees",
                                  race: "Human",
                                  rClass: "Warrior",
                                  spec: "Arms",
                                  specRole: "DPS",
                                  faction: "Alliance",
                                  achievementPoints: 19855,
                                  thumbnailURL: "https://render-eu.worldofwarcraft.com/character/silvermoon/22/191490326-avatar.jpg?alt=wow/static/images/2d/avatar/1-0.jpg",
                                  region: "eu",
                                  realm: "Silvermoon",
                                  profileURL: "https://raider.io/characters/eu/silvermoon/Lochees")
        return character
    }
}

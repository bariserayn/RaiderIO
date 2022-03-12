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
                                  faction: "Alliance",
                                  achievementPoints: 19855,
                                  thumbnailURL: "https://render-eu.worldofwarcraft.com/character/silvermoon/22/191490326-avatar.jpg?alt=wow/static/images/2d/avatar/1-0.jpg",
                                  region: "eu",
                                  realm: "Silvermoon",
                                  profileURL: "https://raider.io/characters/eu/silvermoon/Lochees",
                                  covenant: Covenant(name: "Night Fae"),
                                  gear: Gear(itemLevelEquipped: 244),
                                  guild: Guild(name: "Fury"),
                                  raidProgression: RaidProgression(sepulcherOfTheFirstOnes: RaidInstance(summary: "4/12")),
                                  mythicPlusScoresBySeason: [MythicPlusScoresBySeason(season: "sl-3", segments: Segments(all: All(score: 555, color: ("#fffff"))))],
                                  mythicPlusBestRuns: [MythicPlusRun(dungeon: "Theater of Pain", shortName: "TOP", mythicLevel: 10, keystoneUpgrades: 2, score: 120.5, clearTime: 36, affixes: [Affix(name: "Bolstering"), Affix(name: "Tyrannical")], url: "raider.io")])
        
        return character
    }

    static var mythicRun: MythicPlusRun {
        let mythicRun = MythicPlusRun(dungeon: "Theater of Pain",
                                       shortName: "TOP",
                                       mythicLevel: 15,
                                       keystoneUpgrades: 3,
                                       score: 15.5,
                                       clearTime: 555555,
                                       affixes: [Affix(name: "Tyrannical"),
                                                 Affix(name: "Fortified"),
                                                 Affix(name: "Bolstering")], url: "raider.io")
        return mythicRun
    }
}

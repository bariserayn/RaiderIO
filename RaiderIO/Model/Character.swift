//
//  Character.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import SwiftUI

struct Character: Codable {
    let name: String
    let race: String
    let rClass: String
    let spec: String
    let faction: String
    let achievementPoints: Int
    let thumbnailURL: String
    let region: String
    let realm: String
    let profileURL: String
    let covenant: Covenant
    let gear: Gear
    let guild: Guild?
    let raidProgression: RaidProgression
    let mythicPlusScoresBySeason: [MythicPlusScoresBySeason]
    var mythicPlusBestRuns: [MythicPlusRun]
    
    var guildUrl: String? {
        guard let guild = guild else { return nil }
        let fixedGuildUrl = guild.name.replacingOccurrences(of: " ", with: "%20")
        return "https://raider.io/guilds/\(region)/\(realm)/\(fixedGuildUrl)"
    }
    
    var factionColor: Color {
        if faction == "alliance" {
            return .blue
        } else {
            return .red
        }
    }
    
    var classColor: Color {
        switch rClass {
            case Classes.deathKnight:
                return ClassColors.deathKnightColor
            case Classes.demonHunter:
                return ClassColors.demonHunterColor
            case Classes.druid:
                return ClassColors.druidColor
            case Classes.hunter:
                return ClassColors.hunterColor
            case Classes.mage:
                return ClassColors.mageColor
            case Classes.monk:
                return ClassColors.monkColor
            case Classes.paladin:
                return ClassColors.paladinColor
            case Classes.priest:
                return ClassColors.priestColor
            case Classes.rogue:
                return ClassColors.rogueColor
            case Classes.shaman:
                return ClassColors.shamanColor
            case Classes.warlock:
                return ClassColors.warlockColor
            case Classes.warrior:
                return ClassColors.warriorColor
            default:
                return .white
        }
    }
    
    var covenantName: String {
        switch covenant.name {
            case "Night Fae":
                return Covenants.nightFae
            case "Kyrian":
                return Covenants.kyrian
            case "Venthyr":
                return Covenants.venthyr
            case "Necrolord":
                return Covenants.necrolord
            default:
                return "xmark"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case race
        case rClass = "class"
        case spec = "active_spec_name"
        case faction
        case achievementPoints = "achievement_points"
        case thumbnailURL = "thumbnail_url"
        case region
        case realm
        case profileURL = "profile_url"
        case covenant
        case gear
        case guild
        case raidProgression = "raid_progression"
        case mythicPlusScoresBySeason = "mythic_plus_scores_by_season"
        case mythicPlusBestRuns = "mythic_plus_best_runs"
    }
}

struct Covenant: Codable {
    let name: String
}

struct Gear: Codable {
    let itemLevelEquipped: Int
    
    enum CodingKeys: String, CodingKey {
        case itemLevelEquipped = "item_level_equipped"
    }
}

struct Guild: Codable {
    let name: String
}

struct RaidProgression: Codable {
    let sepulcherOfTheFirstOnes: RaidInstance
    
    enum CodingKeys: String, CodingKey {
        case sepulcherOfTheFirstOnes = "sepulcher-of-the-first-ones"
    }
}

struct RaidInstance: Codable {
    let summary: String
}

struct MythicPlusScoresBySeason: Codable {
    let season: String
    let segments: Segments
}

struct Segments: Codable {
    let all: All
}

struct All: Codable {
    let score: Double
    let color: String
}

struct MythicPlusRun: Codable, Identifiable {
    let id = UUID()
    let dungeon: String
    let shortName: String
    let mythicLevel: Int
    let keystoneUpgrades: Int
    let score: Double
    let clearTime: Int
    let affixes: [Affix]
    
    enum CodingKeys: String, CodingKey {
        case dungeon
        case shortName = "short_name"
        case mythicLevel = "mythic_level"
        case keystoneUpgrades = "num_keystone_upgrades"
        case clearTime = "clear_time_ms"
        case score
        case affixes
    }
}

struct Affix: Codable {
    let name: String
}

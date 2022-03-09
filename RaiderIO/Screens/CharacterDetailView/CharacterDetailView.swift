//
//  CharacterDetailView.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        ZStack {
            Image(character.faction == "alliance" ? "alliancebanner1" : "hordebanner1")
                .resizable()
                .scaledToFill()
                .frame(height: 160)
            
            HStack {
                ZStack {
                    AsyncImage(url: URL(string: character.thumbnailURL)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                }
                
                VStack(alignment: .leading) {
                    Link(character.name, destination: URL(string: character.profileURL)!)
                        .font(.title)
                        .foregroundColor(character.factionColor)
                    
                    if let _ = character.guild {
                        Link("<\(character.guild!.name)>", destination: URL(string: character.guildUrl!)!)
                            .foregroundColor(.white)
                    }
                    
                    Text("(\(character.region.uppercased()))\(character.realm)")
                        .foregroundColor(character.factionColor)
                    HStack {
                        Text(character.race)
                            .foregroundColor(character.factionColor)
                        Text("\(character.spec) \(character.rClass)")
                            .foregroundColor(character.classColor)
                    }
                }
                
                VStack {
                    Text("\(Int(character.mythicPlusScoresBySeason[0].segments.all.score)) M+")
                        .foregroundColor(Color(hex: character.mythicPlusScoresBySeason[0].segments.all.color))
                        .padding(4)
                        .border((Color(hex: character.mythicPlusScoresBySeason[0].segments.all.color)))
                    
                    Text(character.raidProgression.sepulcherOfTheFirstOnes.summary)
                        .foregroundColor(.white)
                        .padding(4)
                        .border(.white)
                }
            }
            .navigationTitle("Current Season")
        }
        Spacer()
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(character: MockData.character)
        
    }
}

//
//  CharacterDetailView.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    @StateObject var viewModel = CharacterDetailViewImpl()
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
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
                                Image(character.covenantName)
                                    .resizable()
                                    .offset(x: 44, y: 40)
                                    .frame(width: 40, height: 40)
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
                        .navigationBarHidden(true)
                    }
                    
                    List {
                        Section(header: Text("Top 10 Timed Run")) {
                            ForEach(character.mythicPlusBestRuns) { mythicRun in
                                CharacterRunCell(mythicRun: mythicRun)
                                    .onTapGesture {
                                        withAnimation {
                                            viewModel.selectedDungeon = mythicRun
                                            viewModel.isShowingDetail = true
                                        }
                                    }
                            }
                        }
                    }.listStyle(.plain)
                }
            }
            .navigationTitle("Current Season")
            .toolbar {
                Button {
                    Task {
                        await viewModel.saveCharacterData(character: character)
                    }
                } label: {
                    Image(systemName: SFSymbol.star)
                }
            }
            
            if viewModel.isShowingDetail {
                FullScreenBlackTransparencyView()
                CharacterDungeonDetailView(mythicPlusRun: viewModel.selectedDungeon!, isShowingDetailModal: $viewModel.isShowingDetail)
            }
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(character: MockData.character)
        
    }
}

fileprivate struct FullScreenBlackTransparencyView: View {
    var body: some View {
        Color(.black)
            .ignoresSafeArea()
            .opacity(0.9)
            .transition(AnyTransition.opacity.animation(.easeOut(duration: 0.35)))
            .zIndex(1)
            .accessibilityHidden(true)
    }
}

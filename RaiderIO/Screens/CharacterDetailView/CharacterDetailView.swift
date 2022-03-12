//
//  CharacterDetailView.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterDetailViewModelImpl
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    ZStack {
                        Image("alliancebanner1")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 160)
                        
                        HStack {
                            ZStack {
                                AsyncImage(url: URL(string: viewModel.character.thumbnailURL)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                                Image(viewModel.character.covenantName)
                                    .resizable()
                                    .offset(x: 45, y: 45)
                                    .frame(width: 40, height: 40)
                            }
                            
                            VStack(alignment: .leading) {
                                Link(viewModel.character.name, destination: URL(string: viewModel.character.profileURL)!)
                                    .font(.title)
                                    .foregroundColor(viewModel.character.factionColor)

                                if let _ = viewModel.character.guild {
                                    Link("<\(viewModel.character.guild!.name)>", destination: URL(string: viewModel.character.guildUrl!)!)
                                        .foregroundColor(.white)
                                }

                                Text("(\(viewModel.character.region.uppercased()))\(viewModel.character.realm)")
                                    .foregroundColor(viewModel.character.factionColor)
                                HStack {
                                    Text(viewModel.character.race)
                                        .foregroundColor(viewModel.character.factionColor)
                                    Text("\(viewModel.character.spec) \(viewModel.character.rClass)")
                                        .foregroundColor(viewModel.character.classColor)
                                }
                            }
                            
                            VStack {
                                Text("\(Int(viewModel.character.mythicPlusScoresBySeason[0].segments.all.score)) M+")
                                    .foregroundColor(Color(hex: viewModel.character.mythicPlusScoresBySeason[0].segments.all.color))
                                    .padding(4)
                                    .border((Color(hex: viewModel.character.mythicPlusScoresBySeason[0].segments.all.color)))
                                
                                Text(viewModel.character.raidProgression.sepulcherOfTheFirstOnes.summary)
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .border(.white)
                            }
                        }
                        .navigationBarHidden(true)
                    }
                    
                    List {
                        Section(header: Text("Top 10 Timed Run")) {
                            ForEach(viewModel.character.mythicPlusBestRuns) { mythicRun in
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
                        await viewModel.saveCharacterData()
                    }
                } label: {
                    Image(systemName: SFSymbol.star)
                }
            }
            
            if viewModel.isShowingDetail {
                FullScreenBlackTransparencyView()
                CharacterDungeonDetailView(mythicRun: viewModel.selectedDungeon!,
                                           isShowingDetailModal: $viewModel.isShowingDetail)
            }
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(viewModel: CharacterDetailViewModelImpl(character: MockData.character))
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

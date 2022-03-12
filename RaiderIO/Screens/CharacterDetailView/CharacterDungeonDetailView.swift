//
//  CharacterDungeonDetailView.swift
//  RaiderIO
//
//  Created by baris on 10.03.2022.
//

import SwiftUI

struct CharacterDungeonDetailView: View {
    let mythicRun: MythicPlusRun
    @Binding var isShowingDetailModal: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Image(mythicRun.dungeon)
                    .resizable()
                    .frame(width: 300, height: 160)
                    .scaledToFill()

                HStack {
                    Text("\(mythicRun.dungeon) +\(mythicRun.mythicLevel)")
                        .font(.title2)
                    ForEach (0..<mythicRun.keystoneUpgrades) { _ in
                        Image(systemName: SFSymbol.starFill)
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.yellow)
                            .padding(-3)
                    }
                }

                VStack {
                    Text("Cleared in \(mythicRun.clearTime.msToSeconds.hourMinuteSecondMS)")
                    Text("Rating increased by \(formatScore(mythicRun.score))")
                    Link("raider.io", destination: URL(string: mythicRun.url)!)
                }
                                
                ZStack {
                    Capsule()
                        .frame(height: 80)
                        .foregroundColor(Color(.tertiarySystemBackground))
                    HStack {
                        ForEach(mythicRun.affixes, id: \.name) { affix in // TODO: filter affixes
                            Image(affix.name)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.bottom, 10)
            }
            .frame(width: 300, height: 360)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
            .overlay(alignment: .topTrailing) {
                Button {
                    withAnimation { isShowingDetailModal = false }
                } label: {
                    XDismissButton()
                }
            }
        }
        .transition(.opacity.combined(with: .identity))
        .zIndex(2)
    }
    
    func formatScore(_ number: Double) -> String {
        String(format: "%.1f", number)
    }
}

struct CharacterDungeonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDungeonDetailView(mythicRun: MockData.mythicRun, isShowingDetailModal: .constant(true))
    }
}

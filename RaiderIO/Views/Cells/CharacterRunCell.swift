//
//  CharacterRunCell.swift
//  RaiderIO
//
//  Created by baris on 10.03.2022.
//

import SwiftUI

struct CharacterRunCell: View {
    let mythicRun: MythicPlusRun
    
    var body: some View {
        HStack {
            HStack {
                Image(mythicRun.shortName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .padding(.leading, 5)
                Text(mythicRun.dungeon)
                    .frame(width: 110, alignment: .leading)
                    .minimumScaleFactor(0.75)
            }
            
            HStack {
                Text("+\(mythicRun.mythicLevel)")
                    .fontWeight(.semibold)
                    .padding(.trailing, -3)
                ForEach (0..<mythicRun.keystoneUpgrades) { _ in
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.yellow)
                        .padding(-3)
                }
            }.frame(width: 60, alignment: .leading)
            
            HStack {
                Text(formatScore(mythicRun.score))
                Text(mythicRun.clearTime.msToSeconds.hourMinuteSecondMS)
            }.frame(alignment: .trailing)
        }
    }
    
    func formatScore(_ number: Double) -> String {
        String(format: "%.1f", number)
    }
}

struct CharacterRunCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRunCell(mythicRun: MockData.mythicRun)
            .previewLayout(.sizeThatFits)
            .previewInterfaceOrientation(.portrait)
    }
}

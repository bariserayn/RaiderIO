//
//  CharacterDungeonDetailView.swift
//  RaiderIO
//
//  Created by baris on 10.03.2022.
//

import SwiftUI

struct CharacterDungeonDetailView: View {
    let mythicPlusRun: MythicPlusRun
    @Binding var isShowingDetailModal: Bool
    
    var body: some View {
        ZStack {
            VStack {
                
            }
            .frame(width: 300, height: 450)
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
        .onAppear {
            print(mythicPlusRun)
        }
        .transition(.opacity.combined(with: .identity))
        .zIndex(2)
    }
}

struct CharacterDungeonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDungeonDetailView(mythicPlusRun: MockData.mythicRun, isShowingDetailModal: .constant(true))
    }
}

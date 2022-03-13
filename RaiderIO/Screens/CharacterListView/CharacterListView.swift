//
//  CharacterListView.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject var viewModel: CharacterListViewModelImpl
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.savedCharacters, id: \.self) { savedCharacter in
                        HStack {
                            AsyncImage(url: URL(string: savedCharacter.imageUrl!)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)
                            Text("\(savedCharacter.name!)-(\(savedCharacter.region!.uppercased()))\(savedCharacter.realm!)")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        
                        .onTapGesture {
                            Task {
                                await viewModel.getCharacterData(region: savedCharacter.region!, realm: savedCharacter.realm!, name: savedCharacter.name!)
                            }
                        }
                    }.onDelete { indexSet in
                        indexSet.forEach { index in
                            let savedCharacter = viewModel.savedCharacters[index]
                            viewModel.deleteCharacter(savedCharacter: savedCharacter)
                            Task {
                                await viewModel.getAllCharacters()
                            }
                        }
                    }
                }
                .navigationTitle("Favorited Characters")
                
                if viewModel.isShowingDetail {
                    NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModelImpl(character: viewModel.character!,
                                                                                                            coreDataManager: CoreDataManager())),
                                   isActive: $viewModel.isShowingDetail) {}
                }
                
                if viewModel.isLoading {
                    LoadingView()
                }
            }
        }
        
        .onAppear {
            Task {
                await viewModel.getAllCharacters()
            }
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(viewModel: CharacterListViewModelImpl(coreDataManager: CoreDataManager(), service: WebServiceImpl()))
    }
}

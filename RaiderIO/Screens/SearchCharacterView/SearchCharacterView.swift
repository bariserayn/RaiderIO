//
//  SearchCharacterView.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import SwiftUI

struct SearchCharacterView: View {
    @StateObject private var viewModel = SearchCharacterViewModelImpl(service: WebServiceImpl())
    @FocusState private var focusedTextField: SearchTextField?
    
    enum SearchTextField {
        case characterName, realm
    }
    
    let regions = ["EU", "US"]
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 40) {
                    Image(Images.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .padding()
                    
                    GroupBox() {
                        Text("Character Search").font(.title2)
                        
                        Picker("Region", selection: $viewModel.region) {
                            ForEach(regions, id: \.self) {
                                Text($0).tag($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .disabled(viewModel.isLoading)
                        
                        TextField("Realm", text: $viewModel.realm)
                            .focused($focusedTextField, equals: .realm)
                            .onSubmit { focusedTextField = .characterName }
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                        
                        TextField("Character Name", text: $viewModel.characterName)
                            .focused($focusedTextField, equals: .characterName)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                        
                    }.padding(7)
                    
                    Button {
                        Task {
                            await viewModel.getCharacterData()
                        }
                    } label: {
                        RIButton(title: "Search")
                    }.disabled(viewModel.isLoading)
                    
                    if viewModel.isShowingDetail {
                        NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModelImpl(character: viewModel.character!)), isActive: $viewModel.isShowingDetail) {}
                    }
                    
                    Spacer()
                }
                
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Dismiss") { focusedTextField = nil }
                }
            }
            .alert(item: $viewModel.alertItem, content: { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: alertItem.dismissButton)
            })
        }
    }
}

struct SearchCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCharacterView()
    }
}

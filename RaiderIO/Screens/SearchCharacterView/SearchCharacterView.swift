//
//  SearchCharacterView.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import SwiftUI

struct SearchCharacterView: View {
    @StateObject private var viewModel = SearchCharacterViewModelImpl()
    @FocusState private var focusedTextField: SearchTextField?
    
    enum SearchTextField {
        case characterName, realm
    }
    
    let regions = ["EU", "NA"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .padding()
                GroupBox {
                    Text("Search Character")
                        .font(.title2)
                    
                    Picker("Region", selection: $viewModel.region) {
                        ForEach(regions, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Character Name", text: $viewModel.characterName)
                        .focused($focusedTextField, equals: .characterName)
                        .onSubmit { focusedTextField = .realm }
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                    
                    TextField("Realm", text: $viewModel.realm)
                        .focused($focusedTextField, equals: .realm)
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                }
                Button {

                } label: {
                    RIButton(title: "Search")
                }
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Dismiss") { focusedTextField = nil }
                }
            }
        }
    }
}

struct SearchCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCharacterView()
    }
}

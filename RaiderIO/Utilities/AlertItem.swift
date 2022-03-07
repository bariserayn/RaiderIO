//
//  AlertItem.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
    
    var alert: Alert {
        Alert(title: title, message: message, dismissButton: dismissButton)
    }
}

struct AlertContext {
    static let invalidSearch = AlertItem(title: Text("Invalid Search"),
                                                message: Text("All fields are required.\nPlease try again."),
                                                dismissButton: .default(Text("Ok")))
}

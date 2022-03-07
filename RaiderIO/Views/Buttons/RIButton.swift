//
//  RIButton.swift
//  RaiderIO
//
//  Created by baris on 7.03.2022.
//

import SwiftUI

struct RIButton: View {
    var title: String
    var color: Color = .brandPrimary
    
    var body: some View {
        Text(title)
            .bold()
            .frame(width: 280, height: 44)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

struct DDGButton_Previews: PreviewProvider {
    static var previews: some View {
        RIButton(title: "Test Button")
            .previewLayout(.sizeThatFits)
    }
}

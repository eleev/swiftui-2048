//
//  FilledBackgroundStyle.swift
//  T2iles
//
//  Created by Astemir Eleev on 19.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct FilledBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .background(Color.primary)
            .cornerRadius(25)
            .animation(.modalSpring, value: configuration.isPressed)
    }
}

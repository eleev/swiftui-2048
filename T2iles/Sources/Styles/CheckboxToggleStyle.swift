//
//  CheckboxToggleStyle.swift
//  T2iles
//
//  Created by Astemir Eleev on 30.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    var size: CGSize = .init(width: 44, height: 44)
    
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "checkmark.circle")
                .resizable()
                .frame(width: size.width, height: size.height)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

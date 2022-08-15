//
//  RoundedClippedBackground.swift
//  T2iles
//
//  Created by Astemir Eleev on 30.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct RoundedClippedBackground: ViewModifier {
    let backgroundColor: Color
    let proxy: GeometryProxy

    func body(content: Content) -> some View {
        content
            .background(Rectangle().fill(backgroundColor))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.primary.opacity(0.3), radius: 20)
    }
}


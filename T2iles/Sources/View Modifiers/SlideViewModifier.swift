//
//  SlideViewModifier.swift
//  T2iles
//
//  Created by Astemir Eleev on 30.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct SlideViewModifier<T: Gesture>: ViewModifier {
    var gesture: T
    @Binding var presentEndGameModal: Bool
    @Binding var presentSideMenu: Bool
    
    func body(content: Content) -> some View {
        content
            .gesture(gesture, including: .all)
            .scaleEffect((presentEndGameModal || presentSideMenu) ? 0.9 : 1.0)
            .allowsHitTesting(!(presentEndGameModal || presentSideMenu))
    }
}

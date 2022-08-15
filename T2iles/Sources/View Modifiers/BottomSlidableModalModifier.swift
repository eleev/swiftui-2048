//
//  BottomSlidableModalModifier.swift
//  T2iles
//
//  Created by Astemir Eleev on 30.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct BottomSlidableModalModifier: ViewModifier {
    let proxy: GeometryProxy
    @Binding var presentEndGameModal: Bool
    @Binding var sideMenuViewState: CGSize
    @Binding var hasGameEnded: Bool
    var onGameEndCompletion: () -> Void = {  }
    let sideMenuDragHeight: CGFloat = 100
    
    func body(content: Content) -> some View {
        content
            .offset(y: presentEndGameModal ? (proxy.size.height / 2.0) : (proxy.size.height + proxy.size.height / 2))
            .offset(y: sideMenuViewState.height)
            .animation(.modalSpring, value: presentEndGameModal)
            .gesture(
                DragGesture().onChanged { value in
                    if value.translation.height > 0 {
                        sideMenuViewState.height = value.translation.height
                    }
                }
                .onEnded { value in
                    if sideMenuViewState.height > sideMenuDragHeight {
                        withAnimation(.modalSpring) {
                            presentEndGameModal = false
                            hasGameEnded = false
                            onGameEndCompletion()
                        }
                    }
                    sideMenuViewState = .zero
                }
        )
    }
}

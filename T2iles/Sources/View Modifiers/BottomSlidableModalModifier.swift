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
    
    func body(content: Content) -> some View {
        content
            .offset(y: self.presentEndGameModal ? (proxy.size.height / 2.0) : (proxy.size.height + proxy.size.height / 2))
            .offset(y: self.sideMenuViewState.height)
            .animation(.modalSpring)
            .gesture(
                DragGesture().onChanged { value in
                    if value.translation.height > 0 {
                        self.sideMenuViewState.height = value.translation.height
                    }
                }
                .onEnded { value in
                    if self.sideMenuViewState.height > 100 {
                        
                        withAnimation(.modalSpring) {
                            self.presentEndGameModal = false
                            self.hasGameEnded = false
                            self.onGameEndCompletion()
                        }
                    }
                    self.sideMenuViewState = .zero
                }
        )
    }
}

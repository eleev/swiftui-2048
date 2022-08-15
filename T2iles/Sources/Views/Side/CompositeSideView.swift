//
//  CompositeSideView.swift
//  T2iles
//
//  Created by Astemir Eleev on 31.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct CompositeSideView: View {
    @Binding var selectedView: SelectedView
    @Binding var sideMenuViewState: CGSize
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        GeometryReader { proxy in
            SideMenuView(selectedView: $selectedView, onMenuChangeHandler: {
                withAnimation(.modalSpring) {
                    presentSideMenu = false
                }
            })
                .offset(x: presentSideMenu ? -(proxy.size.width / 2.0) : -(proxy.size.width + proxy.size.width / 2))
                .offset(x: -sideMenuViewState.width)
                .rotation3DEffect(Angle(degrees: presentSideMenu ? Double(sideMenuViewState.width / 10) + 10 : 0), axis: (x: 0, y: 10, z: 0))
                .animation(.modalSpring, value: presentSideMenu)
                .gesture(
                    DragGesture().onChanged { value in
                        if value.translation.width < 0 {
                            sideMenuViewState.width = -value.translation.width
                        }
                    }
                    .onEnded { value in
                        if sideMenuViewState.width > 100 {
                            withAnimation(.modalSpring) {
                                presentSideMenu = false
                            }
                        }
                        sideMenuViewState = .zero
                    }
            )
        }
    }
}

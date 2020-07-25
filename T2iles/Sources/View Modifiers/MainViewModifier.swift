//
//  MainViewModifier.swift
//  T2iles
//
//  Created by Astemir Eleev on 30.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct MainViewModifier: ViewModifier {
    let proxy: GeometryProxy
    @Binding var presentEndGameModal: Bool
    @Binding var presentSideMenu: Bool
    @Binding var viewState: CGSize
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    func body(content: Content) -> some View {
        content
            .offset(y: self.presentEndGameModal ? self.horizontalSizeClass == .regular ? (proxy.size.width < proxy.size.height ? -proxy.size.height / 4 : -proxy.size.height / 3) : -proxy.size.height / 3 : 0)
            .rotation3DEffect(Angle(degrees: self.presentEndGameModal ? proxy.size.width < proxy.size.height ? Double(self.viewState.height / 10) - 10 : Double(self.viewState.height / 10) - 20 : 0), axis: (x: 10.0, y: 0, z: 0))
            .scaleEffect(self.presentEndGameModal ? 0.9 : 1)
            .rotation3DEffect(Angle(degrees: self.presentSideMenu ? Double(self.viewState.width / 10) - (self.horizontalSizeClass == .regular ? 10 : 20) : 0), axis: (x: 0, y: 10, z: 0))
            .offset(x: self.presentSideMenu ? (self.horizontalSizeClass == .regular ? proxy.size.width / 3 : proxy.size.width / 1.5) : 0)
            .offset(x: -self.viewState.width)
            .scaleEffect(self.presentSideMenu ? 0.9 : 1)
    }
}

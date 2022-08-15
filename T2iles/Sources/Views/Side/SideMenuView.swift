//
//  SideMenuView.swift
//  T2iles
//
//  Created by Astemir Eleev on 19.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct SideMenuView: View {
    
    // MARK: - Environment Properties
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Environment(\.colorSchemeBackgroundTheme) private var colorSchemeBackgroundTheme: ColorSchemeBackgroundTheme

    // MARK: - Properties
    
    @Binding var selectedView: SelectedView
    var onMenuChangeHandler: () -> Void
    var items: [SelectedView] = [ .game, .settings, .about ]
    
    // MARK: - Constants
    
    let interItemSpacing: CGFloat = 44
    let cornerRadius: CGFloat = 25
    
    // MARK: - Conformance to View protocol
    
    var body: some View {
        GeometryReader { proxy in
            Group {
                VStack(spacing: interItemSpacing) {
                    Spacer()
                    ForEach(0..<items.count, id: \.self) { item in
                        self.item(named: items[item].title) {
                            selectedView = items[item]
                            onMenuChangeHandler()
                        }
                    }
                    Spacer()
                }
                .padding()
                .padding([.leading, .trailing])
                .padding(.leading, proxy.size.width > proxy.size.height ? 32 : (horizontalSizeClass == .regular ? 16 : 4) )
            }
            .background(Rectangle().fill(colorSchemeBackgroundTheme.backgroundColor(for: colorScheme)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.primary.opacity(0.3), radius: 20)
            .alignmentGuide(HorizontalAlignment.center) {
                $0[HorizontalAlignment.leading]
            }
            .frame(height: proxy.size.height / 1.15)
            .center(in: .local, with: proxy)
        }
    }
    
    // MARK: - Private Methods
    
    private func item(named name: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(name)
                .font(.system(.title, design: .monospaced))
                .bold()
                .foregroundColor(.primary)
                .animation(.modalSpring)
                .shadow(
                    color: colorSchemeBackgroundTheme.invertedBackgroundColor(for: colorScheme),
                    radius: cornerRadius
                )
        }.eraseToAnyView
    }
}

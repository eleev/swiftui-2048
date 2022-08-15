//
//  SettingsView.swift
//  T2iles
//
//  Created by Astemir Eleev on 30.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct SettingsView: View {

    // MARK: - Environment
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    // MARK: - Private Properties
    
    private var invertedBackgroundColor: Color {
        colorScheme == .dark ? Color(red:0.90, green:0.90, blue:0.90, opacity:1.00) : Color(red:0.10, green:0.10, blue:0.10, opacity:1.00)
    }
    private let previewSize: CGSize = .init(width: 144, height: 144)
    
    private let plist = PlistConfiguration(name: "Strings")
    private let settings: [String : [String : String]]
    
    // MARK: - Initializers
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        settings = plist?.getItem(named: PlistConfigurationKeyPath.settings.rawValue) ?? ["" : [:]]
    }
    
    // MARK: - Conformance to View protocol
    
    var body: some View {
        List {
            Section(header:
                VStack(alignment: .leading) {
                    Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.gameBoardSize.rawValue] ?? "")
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(Color.primary.opacity(0.5))
                        .fontWeight(.black)
                    Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.gameBoardDescription.rawValue] ?? "")
                        .font(.system(.caption, design: .monospaced))
                        .foregroundColor(Color.primary.opacity(0.5))
                        .fontWeight(.bold)
                }
            ) {
                TileBoardSettingView(
                    invertedBackgroundColor: invertedBackgroundColor,
                    previewSize: previewSize
                )
            }
            Section(header:
                VStack(alignment: .leading) {
                    Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.audio.rawValue] ?? "")
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(Color.primary.opacity(0.5))
                        .fontWeight(.black)
                    Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.audioDescription.rawValue] ?? "")
                        .font(.system(.caption, design: .monospaced))
                        .foregroundColor(Color.primary.opacity(0.5))
                        .fontWeight(.bold)
                }
            ) {
                AudioSettingView(
                    invertedBackground: invertedBackgroundColor,
                    previewSize: previewSize
                )
            }
        }
        .listStyle(InsetGroupedListStyle())
        .foregroundColor(.clear)
        .environment(\.horizontalSizeClass, .regular)
        .edgesIgnoringSafeArea(.bottom)
    }
}

//
//  ColorSchemeBackgroundThemeEnvironmentKey.swift
//  T2iles
//
//  Created by Astemir Eleev on 31.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct ColorSchemeBackgroundThemeEnvironmentKey: EnvironmentKey {
    public static let defaultValue: ColorSchemeBackgroundTheme = StandardBackgroundColorScheme()
}

extension EnvironmentValues {
    var colorSchemeBackgroundTheme: ColorSchemeBackgroundTheme {
        set { self[ColorSchemeBackgroundThemeEnvironmentKey.self] = newValue }
        get { self[ColorSchemeBackgroundThemeEnvironmentKey.self] }
    }
}

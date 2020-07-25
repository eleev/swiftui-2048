//
//  TileBoardSizeEnvironmentKey.swift
//  T2iles
//
//  Created by Astemir Eleev on 03.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct TileBoardSizeEnvironmentKey: EnvironmentKey {
    public static let defaultValue: Int = 4
}

extension EnvironmentValues {
    var tileBoardSize: Int {
        set { self[TileBoardSizeEnvironmentKey.self] = newValue }
        get { self[TileBoardSizeEnvironmentKey.self] }
    }
}

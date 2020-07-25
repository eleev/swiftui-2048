//
//  GameBoardSizeEnvironmentKey.swift
//  T2iles
//
//  Created by Astemir Eleev on 30.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct GameBoardSizeEnvironmentKey: EnvironmentKey {
    public static let defaultValue: BoardSize = .fourByFour
}

extension EnvironmentValues {
    var gameBoardSize: BoardSize {
        set { self[GameBoardSizeEnvironmentKey.self] = newValue }
        get { self[GameBoardSizeEnvironmentKey.self] }
    }
}

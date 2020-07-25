//
//  SelectedView.swift
//  T2iles
//
//  Created by Astemir Eleev on 31.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import Foundation

enum SelectedView {
    case game
    case settings
    case about
    
    var title: String {
        switch self {
        case .game:
            return "T2iles"
        case .settings:
            return "Settings"
        case .about:
            return "About"
        }
    }
}

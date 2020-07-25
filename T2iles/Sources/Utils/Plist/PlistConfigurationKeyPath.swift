//
//  PlistConfigurationKeyPath.swift
//  T2iles
//
//  Created by Astemir Eleev on 21.07.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import Foundation

enum PlistConfigurationKeyPath: String {
    
    // MARK: - About
    
    case about
    case copyright
    case linkDescription
    case linkUrl
    
    // MARK: - Settings
    
    case settings
    case gameBoardDescription
    case gameBoardSize
    case audio
    case audioDescription
    
    // MARK: - Game Board State
    
    case gameState
    case gameOverTitle
    case gameOverSubtitle
    case resetGameTitle
    case resetGameSubtitle
}

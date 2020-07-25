//
//  StandardTileColorTheme.swift
//  T2iles
//
//  Created by Astemir Eleev on 31.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import Foundation
import struct SwiftUI.Color

struct StandardTileColorTheme: TileColorTheme {
    var lightTileColors: [TilePair] = [
        (Color(red:0.91, green:0.87, blue:0.83, opacity:1.00), Color(red:0.42, green:0.39, blue:0.35, opacity: 1.00)), // 2
        (Color(red:0.90, green:0.86, blue:0.76, opacity:1.00), Color(red:0.42, green:0.39, blue:0.35, opacity: 1.00)), // 4
        (Color(red:0.93, green:0.67, blue:0.46, opacity:1.00), Color.white), // 8
        (Color(red:0.94, green:0.57, blue:0.38, opacity:1.00), Color.white), // 16
        (Color(red:0.95, green:0.46, blue:0.33, opacity:1.00), Color.white), // 32
        (Color(red:0.94, green:0.35, blue:0.23, opacity:1.00), Color.white), // 64
        (Color(red:0.91, green:0.78, blue:0.43, opacity:1.00), Color.white), // 128
        (Color(red:0.91, green:0.78, blue:0.37, opacity:1.00), Color.white), // 256
        (Color(red:0.90, green:0.77, blue:0.31, opacity:1.00), Color.white), // 512
        (Color(red:0.91, green:0.75, blue:0.24, opacity:1.00), Color.white), // 1024
        (Color(red:0.91, green:0.74, blue:0.18, opacity:1.00), Color.white), // 2048
        (Color(red:0.91, green:0.72, blue:0.12, opacity:1.00), Color.white), // 4096
    ]
    
    var darkTileColors: [TilePair] = [
        (Color(red:0.81, green:0.77, blue:0.73, opacity:1.00), Color(red:0.32, green:0.29, blue:0.25, opacity: 1.00)), // 2
        (Color(red:0.80, green:0.76, blue:0.66, opacity:1.00), Color(red:0.32, green:0.29, blue:0.5, opacity: 1.00)), // 4
        (Color(red:0.83, green:0.57, blue:0.36, opacity:1.00), Color.white), // 8
        (Color(red:0.84, green:0.47, blue:0.28, opacity:1.00), Color.white), // 16
        (Color(red:0.85, green:0.36, blue:0.23, opacity:1.00), Color.white), // 32
        (Color(red:0.84, green:0.25, blue:0.13, opacity:1.00), Color.white), // 64
        (Color(red:0.81, green:0.68, blue:0.33, opacity:1.00), Color.white), // 128
        (Color(red:0.81, green:0.68, blue:0.27, opacity:1.00), Color.white), // 256
        (Color(red:0.80, green:0.67, blue:0.21, opacity:1.00), Color.white), // 512
        (Color(red:0.81, green:0.65, blue:0.14, opacity:1.00), Color.white), // 1024
        (Color(red:0.81, green:0.64, blue:0.08, opacity:1.00), Color.white), // 2048
        (Color(red:0.81, green:0.62, blue:0.02, opacity:1.00), Color.white), // 4096
    ]
}

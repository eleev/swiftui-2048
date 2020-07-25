//
//  Direction.swift
//  T2iles
//
//  Created by Astemir Eleev on 03.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

enum Direction: String {
    
    // MARK: - Cases
    
    case left
    case right
    case up
    case down
    
    // MARK: - Computed Properties
    
    var edge: Edge {
        switch self {
        case .left:
            return .leading
        case .right:
            return .trailing
        case .up:
            return .top
        case .down:
            return .bottom
        }
    }
    
    var invertedEdge: Edge {
        edge.inverted
    }
}

extension Direction {
    var systemImageName: String {
        return "arrow." + rawValue + ".circle"
    }
}

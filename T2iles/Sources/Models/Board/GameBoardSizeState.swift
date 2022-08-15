//
//  GameBoardSizeState.swift
//  T2iles
//
//  Created by Astemir Eleev on 30.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct GameBoardSizeState {
    
    // MARK: - Properties
        
    private(set) var boardSize: BoardSize = .fourByFour {
        didSet {
            defaults.set(boardSize.rawValue, forKey: Notification.Name.gameBoardSize.rawValue)
            publishState()
        }
    }
    
    var is3x3On: Bool = false {
        willSet {
            if newValue {
                boardSize = .threeByThree
                is4x4On = false
                is5x5On = false
            }
        }
    }
    var is4x4On: Bool = false {
        willSet {
            if newValue {
                boardSize = .fourByFour
                is3x3On = false
                is5x5On = false
            }
        }
    }
    var is5x5On: Bool = false {
        willSet {
            if newValue {
                boardSize = .fiveByFive
                is3x3On = false
                is4x4On = false
            }
        }
    }
    
    // MARK: - Constants
    
    let defaults: UserDefaults
    
    // MARK: - Internal Types
    
    enum Suit: String {
        case production
        case test
        
        var userDefaults: UserDefaults? {
            switch self {
            case .production:
                return .standard
            case .test:
                return UserDefaults(suiteName: Suit.test.rawValue)
            }
        }
    }
    
    // MARK: - Initializers
    
    init(suit: Suit = .production) {
        defaults = suit.userDefaults ?? .standard
        
        let rawValue = defaults.integer(forKey: Notification.Name.gameBoardSize.rawValue)
        self.boardSize = BoardSize(rawValue: rawValue) ?? BoardSize.fourByFour
        
        switch boardSize {
        case .threeByThree:
            is3x3On = true
        case .fourByFour:
            is4x4On = true
        case .fiveByFive:
            is5x5On = true
        }
    }
    
    // MARK: - Private Methods
    
    private func publishState() {
        NotificationCenter.default.post(
            name: .gameBoardSize,
            object: nil,
            userInfo: [Notification.Name.gameBoardSizeUserInfoKey : boardSize]
        )
    }
}

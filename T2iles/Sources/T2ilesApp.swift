//
//  T2ilesApp.swift
//  T2iles
//
//  Created by Astemir Eleev on 25.07.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

@main
struct T2ilesApp: App {
    
    private var mainView: some View {
        let rawValue = UserDefaults.standard.integer(forKey: Notification.Name.gameBoardSize.rawValue)
        let boardSize = BoardSize(rawValue: rawValue) ?? BoardSize.fourByFour
        let initialBoardSizeRawValue = boardSize.rawValue
        
        return CompositeView(board: GameLogic(size: initialBoardSizeRawValue))
    }
    
    var body: some Scene {
        WindowGroup {
            mainView
        }
    }
}

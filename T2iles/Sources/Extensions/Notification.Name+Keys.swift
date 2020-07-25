//
//  Notification.Name+Keys.swift
//  T2iles
//
//  Created by Astemir Eleev on 30.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var gameBoardSize = Notification.Name("eleev.astemir.2048-swiftui-game.board.size")
    static var gameBoardSizeUserInfoKey = "game.board.size"
    
    static var audio = Notification.Name("eleev.astemir.2048-swiftui-audio")
    static var audioUserInfoKey = "audio"

}

//
//  AudioSource.swift
//  T2iles
//
//  Created by Astemir Eleev on 30.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import Foundation

enum AudioSource: String {
    case merge = "Merge"
    case add = "Add"
}

extension AudioSource {
    
    static func play(condition: @escaping @autoclosure () -> Bool) {
        DispatchQueue.main.async {
            if condition() {
                play(from: .moved)
            }
            play(from: .merged)
        }
    }
    
    static func play(from source: GameLogic.State) {
        switch source {
        case .merged:
            Audio.play(fileNamed: AudioSource.merge.rawValue)
        case .moved:
            Audio.play(fileNamed: AudioSource.add.rawValue)
        default:
            ()
        }
    }
}

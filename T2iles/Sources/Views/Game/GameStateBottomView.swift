//
//  GameStateBottomView.swift
//  T2iles
//
//  Created by Astemir Eleev on 31.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct GameStateBottomView: View {
    
    @Binding var hasGameEnded: Bool
    @Binding var presentEndGameModal: Bool
    @Binding var sideMenuViewState: CGSize
    @Binding var score: Int
    var resetGame: () -> Void
    
    private let plist = PlistConfiguration(name: "Strings")
    private let gameBoardState: [String : [String : String]]
    
    init(hasGameEnded: Binding<Bool>,
         presentEndGameModal: Binding<Bool>,
         sideMenuViewState: Binding<CGSize>,
         score: Binding<Int>,
         resetGame: @escaping () -> Void) {
        self._hasGameEnded = hasGameEnded
        self._presentEndGameModal = presentEndGameModal
        self._sideMenuViewState = sideMenuViewState
        self._score = score
        self.resetGame = resetGame
        
        gameBoardState = plist?.getItem(named: PlistConfigurationKeyPath.gameState.rawValue) ?? ["" : [:]]
    }
    
    var body: some View {
        GeometryReader { proxy in
            if self.hasGameEnded {
                ModalView(title: gameBoardState[PlistConfigurationKeyPath.gameState.rawValue]?[PlistConfigurationKeyPath.gameOverTitle.rawValue] ?? "",
                          subtitle: (gameBoardState[PlistConfigurationKeyPath.gameState.rawValue]?[PlistConfigurationKeyPath.gameOverSubtitle.rawValue] ?? "") + "\(score)", completionHandler: {
                    withAnimation(.modalSpring) {
                        resetGame()
                        presentEndGameModal = false
                    }
                    hasGameEnded = false
                })
                    .modifier(BottomSlidableModalModifier(proxy: proxy,
                                                          presentEndGameModal: $presentEndGameModal,
                                                          sideMenuViewState: $sideMenuViewState,
                                                          hasGameEnded: $hasGameEnded,
                                                          onGameEndCompletion: {
                                                            resetGame() // Reset the game on interactive dismiss gesture
                    }))
            } else {
                ModalView(title: gameBoardState[PlistConfigurationKeyPath.gameState.rawValue]?[PlistConfigurationKeyPath.resetGameTitle.rawValue] ?? "", subtitle: gameBoardState[PlistConfigurationKeyPath.gameState.rawValue]?[PlistConfigurationKeyPath.resetGameSubtitle.rawValue] ?? "", completionHandler: {
                    withAnimation(.modalSpring) {
                        resetGame()
                        presentEndGameModal = false
                    }
                }) {
                    withAnimation(.modalSpring) {
                        presentEndGameModal = false
                    }
                }
                .modifier(BottomSlidableModalModifier(proxy: proxy,
                                                      presentEndGameModal: $presentEndGameModal,
                                                      sideMenuViewState: $sideMenuViewState,
                                                      hasGameEnded: .constant(false)))
            }
        }
    }
}

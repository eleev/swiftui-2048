//
//  GameStateBottomView.swift
//  T2iles
//
//  Created by Astemir Eleev on 31.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct GameStateBottomView: View {
    
    // MARK: - Properties
    
    @Binding var hasGameEnded: Bool
    @Binding var presentEndGameModal: Bool
    @Binding var sideMenuViewState: CGSize
    @Binding var score: Int
    var resetGame: () -> Void
    
    private let plist = PlistConfiguration(name: "Strings")
    private let gameBoardState: [String : [String : String]]
    
    // MARK: - Initializers
    
    init(
        hasGameEnded: Binding<Bool>,
        presentEndGameModal: Binding<Bool>,
        sideMenuViewState: Binding<CGSize>,
        score: Binding<Int>,
        resetGame: @escaping () -> Void
    ) {
        _hasGameEnded = hasGameEnded
        _presentEndGameModal = presentEndGameModal
        _sideMenuViewState = sideMenuViewState
        _score = score
        self.resetGame = resetGame
        
        gameBoardState = plist?.getItem(named: PlistConfigurationKeyPath.gameState.rawValue) ?? ["" : [:]]
    }
    
    // MARK: - Views
    
    private var modalGameEnd: some View {
        ModalView(
            title: gameBoardState[PlistConfigurationKeyPath.gameState.rawValue]?[PlistConfigurationKeyPath.gameOverTitle.rawValue] ?? "",
            subtitle: (gameBoardState[PlistConfigurationKeyPath.gameState.rawValue]?[PlistConfigurationKeyPath.gameOverSubtitle.rawValue] ?? "") + "\(score)",
            completionHandler: {
                withAnimation(.modalSpring) {
                    resetGame()
                    presentEndGameModal = false
                }
                hasGameEnded = false
            }
        )
    }
    
    private var modalExistingGame: some View {
        ModalView(
            title: gameBoardState[PlistConfigurationKeyPath.gameState.rawValue]?[PlistConfigurationKeyPath.resetGameTitle.rawValue] ?? "",
            subtitle: gameBoardState[PlistConfigurationKeyPath.gameState.rawValue]?[PlistConfigurationKeyPath.resetGameSubtitle.rawValue] ?? "",
            completionHandler: {
                withAnimation(.modalSpring) {
                    resetGame()
                    presentEndGameModal = false
                }
            }
        ) {
            withAnimation(.modalSpring) {
                presentEndGameModal = false
            }
        }
    }
    
    // MARK: - Conformance to View protocol
    
    var body: some View {
        GeometryReader { proxy in
            switch hasGameEnded {
            case true:
                modalGameEnd
                    .modifier(bottomGameOverSheet(proxy))
            case false:
                modalExistingGame
                    .modifier(bottomExistingGameSheet(proxy))
            }
        }
    }
    
    // MARK: - Private View Modifiers
    
    private func bottomGameOverSheet(_ proxy: GeometryProxy) -> some ViewModifier {
        BottomSlidableModalModifier(
            proxy: proxy,
            presentEndGameModal: $presentEndGameModal,
            sideMenuViewState: $sideMenuViewState,
            hasGameEnded: $hasGameEnded,
            onGameEndCompletion: {
                resetGame() // Reset the game on interactive dismiss gesture
            }
        )
    }
    
    private func bottomExistingGameSheet(_ proxy: GeometryProxy) -> some ViewModifier {
        BottomSlidableModalModifier(
            proxy: proxy,
            presentEndGameModal: $presentEndGameModal,
            sideMenuViewState: $sideMenuViewState,
            hasGameEnded: .constant(false)
        )
    }
}

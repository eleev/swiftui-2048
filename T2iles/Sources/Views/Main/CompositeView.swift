//
//  CompositeView.swift
//  T2iles
//
//  Created by Astemir Eleev on 03.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI
import Combine

struct CompositeView: View {
    
    // MARK: - Proeprties
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @State private var ignoreGesture = false
    @State private var presentEndGameModal = false
    @State private var hasGameEnded = false
    @State private var viewState = CGSize.zero
    
    @State private var sideMenuViewState = CGSize.zero
    @State private var presentSideMenu = false
    
    @ObservedObject private var logic: GameLogic
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Environment(\.colorSchemeBackgroundTheme) private var colorSchemeBackgroundTheme: ColorSchemeBackgroundTheme
    
    @State private var selectedView: SelectedView = .game
    @State private var score: Int = 0
    @State private var scoreMultiplier: Int = 0
    
    @AppStorage(AppStorageKeys.audio.rawValue) var isAudioEnabled: Bool = true
    
    // MARK: - Initializers
    
    init(board: GameLogic) {
        self.logic = board
    }
    
    // MARK: - Drag Gesture
    
    private var gesture: some Gesture {
        let threshold: CGFloat = 25
        
        let drag = DragGesture()
            .onChanged { v in
                guard !ignoreGesture else { return }
                
                guard abs(v.translation.width) > threshold ||
                    abs(v.translation.height) > threshold else {
                        return
                }
                withTransaction(Transaction()) {
                    ignoreGesture = true
                    
                    if v.translation.width > threshold {
                        // Move right
                        logic.move(.right)
                    } else if v.translation.width < -threshold {
                        // Move left
                        logic.move(.left)
                    } else if v.translation.height > threshold {
                        // Move down
                        logic.move(.down)
                    } else if v.translation.height < -threshold {
                        // Move up
                        logic.move(.up)
                    }
                }
        }
        .onEnded { _ in
            ignoreGesture = false
        }
        return drag
    }
    
    // MARK: - Comformance to View protocol
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                VStack {
                    Group {
                        self.headerView(proxy)

                        FactoryContentView(
                            selectedView: $selectedView,
                            gesture: gesture,
                            gameLogic: logic,
                            presentEndGameModal: $presentEndGameModal,
                            presentSideMenu: $presentSideMenu
                        )
                        .onReceive(logic.$score) { (publishedScore) in
                            score = publishedScore
                        }
                        .onReceive(logic.$mergeMultiplier) { (publishedScoreMultiplier) in
                            scoreMultiplier = publishedScoreMultiplier
                        }
                        .onReceive(logic.$hasMoveMergedTiles) { hasMergedTiles in
                            guard isAudioEnabled else { return }
                            AudioSource.play(condition: hasMergedTiles)
                        }
                    }
                    .blur(radius: (presentEndGameModal || presentSideMenu) ? 4 : 0)
                }
                .modifier(RoundedClippedBackground(backgroundColor: colorSchemeBackgroundTheme.backgroundColor(for: colorScheme),
                                                   proxy: proxy))
                .modifier(
                    MainViewModifier(
                        proxy: proxy,
                        presentEndGameModal: $presentEndGameModal,
                        presentSideMenu: $presentSideMenu,
                        viewState: $viewState
                    )
                )
                .onTapGesture {
                    guard !hasGameEnded else { return } // Disable on tap dismissal of the end game modal view
                        
                        withAnimation(.modalSpring) {
                            presentEndGameModal = false
                            presentSideMenu = false
                        }
                }
                .onReceive(logic.$noPossibleMove) { (publisher) in
                    let hasGameEnded = logic.noPossibleMove
                    self.hasGameEnded = hasGameEnded
                    
                    withAnimation(.modalSpring) {
                        self.presentEndGameModal = hasGameEnded
                    }
                }
                
                GameStateBottomView(
                    hasGameEnded: $hasGameEnded,
                    presentEndGameModal: $presentEndGameModal,
                    sideMenuViewState: $sideMenuViewState,
                    score: $score,
                    resetGame: resetGame
                )
                CompositeSideView(
                    selectedView: $selectedView,
                    sideMenuViewState: $sideMenuViewState,
                    presentSideMenu: $presentSideMenu
                )
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    // MARK: - Methods
    
    private func headerView(_ proxy: GeometryProxy) -> some View {
        HeaderView(
            proxy: proxy,
            showSideMenu: $presentSideMenu,
            title: selectedView.title,
            score: $score,
            scoreMultiplier: $scoreMultiplier,
            newGameAction: {
                presentEndGameModal = true
            },
            showResetButton: {
                selectedView == .game
            }
        )
    }
    
    private func resetGame() {
        logic.reset()
    }
}

// MARK: - Previews

struct CompositeView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            CompositeView(
                board: GameLogic(size: BoardSize.fourByFour.rawValue)
            )
            .colorScheme(.dark)
    
            CompositeView(
                board: GameLogic(size: BoardSize.fourByFour.rawValue)
            )
            .colorScheme(.light)
        }
    }
}

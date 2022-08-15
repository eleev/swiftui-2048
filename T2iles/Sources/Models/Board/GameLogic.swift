//
//  GameLogic.swift
//  T2iles
//
//  Created by Astemir Eleev on 03.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI
import Combine

final class GameLogic: ObservableObject {

    // MARK: - Conformance to ObservableObject protocol
    
    var objectWillChange = PassthroughSubject<GameLogic, Never>()
        
    // MARK: - Typealiases
    
    typealias TileMatrixType = TileMatrix<IdentifiedTile>
    
    // MARK: - Publishd Properties
    
    @Published private(set) var noPossibleMove: Bool = false
    @Published private(set) var score: Int = 0
    @Published private(set) var mergeMultiplier: Int = 0
    @Published private(set) var boardSize: Int
    @Published private(set) var hasMoveMergedTiles: Bool = false
    
    private(set) var lastGestureDirection: Direction = .up

    private let mergeMultiplierStep: Int = 2
    private var instanceId = 0
    private var mutableInstanceId: Int {
        instanceId += 1
        return instanceId
    }
    private var cancellables = Set<AnyCancellable>()
    private var tileMatrix: TileMatrixType!
    
    var tiles: TileMatrixType {
        return tileMatrix
    }

    // MARK: - Initializers
    
    init(size: Int) {
        boardSize = size
        reset(boardSize: size)
        
        NotificationCenter
            .default
            .publisher(for: .gameBoardSize)
            .map {
                $0.userInfo?[Notification.Name.gameBoardSizeUserInfoKey] as? BoardSize
        }
        .sink { [unowned self] in
            guard let gameBoardSize = $0 else { return }
            let rawValue = gameBoardSize.rawValue
            reset(boardSize: rawValue)
        }.store(in: &cancellables)
    }
    
    func reset() {
        reset(boardSize: boardSize)
    }
    
    func resetLastGestureDirection() {
        lastGestureDirection = .up
        objectWillChange.send(self)
    }
    
    enum State {
        case moved
        case merged
        case none
    }
    
    @discardableResult
    func move(_ direction: Direction) -> State {
        defer { objectWillChange.send(self) }
        defer { OperationQueue.main.addOperation { self.resetLastGestureDirection() } }
        
        lastGestureDirection = direction

        var moved = false
        var hasMergedBlocks: Bool = false

        let axis = direction == .left || direction == .right
        let previousMatrixSnapshot = tileMatrix
        
        for row in 0..<boardSize {
            var rowSnapshot = [IdentifiedTile?]()
            var compactRow = [IdentifiedTile]()
           
            computeIntermediateSnapshot(
                &rowSnapshot,
                &compactRow,
                axis: axis,
                currentRow: row
            )
            
            if merge(blocks: &compactRow, reverse: direction == .down || direction == .right) {
                hasMergedBlocks = true
            }
            
            var newRow = [IdentifiedTile?]()
            compactRow.forEach { newRow.append($0) }

            if compactRow.count < boardSize {
                nilout(rowCount: newRow.count, direction: direction, row: &newRow)
            }

            newRow.enumerated().forEach {
                if rowSnapshot[$0]?.value != $1?.value {
                    moved = true
                }
                tileMatrix.add($1, to: axis ? ($0, row) : (row, $0))
            }
        }
        return finalizeMove(
            previousMatrixSnapshot,
            hasMoved: moved,
            hasMergedBlocks: hasMergedBlocks
        )
    }
    
    // MARK: - Private Methods
    
    private func computeIntermediateSnapshot(
        _ rowSnapshot: inout [IdentifiedTile?],
        _ compactRow: inout [IdentifiedTile],
        axis: Bool,
        currentRow row: Int
    ) {
        for col in 0..<boardSize {
            if let block = tileMatrix[axis ? (col, row) : (row, col)] {
                rowSnapshot.append(block)
                compactRow.append(block)
            }
            rowSnapshot.append(nil)
        }
    }
    
    private func nilout(rowCount: Int, direction: Direction, row: inout [IdentifiedTile?]) {
        for _ in 0..<(boardSize - rowCount) {
            if direction == .left || direction == .up {
                row.append(nil)
            } else {
                row.insert(nil, at: 0)
            }
        }
    }
    
    private func finalizeMove(_ previousMatrixSnapshot: TileMatrixType?, hasMoved moved: Bool, hasMergedBlocks: Bool) -> State {
        let areEqual = previousMatrixSnapshot?.equals(to: tileMatrix)
        
        if moved && !(areEqual!) {
            var result: State = .moved
            
            if hasMergedBlocks == false {
                self.mergeMultiplier = 0
                result = .merged
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.025 * TimeInterval(self.boardSize)) {
                self.generateBlocks(generator: .single)
                self.hasMoveMergedTiles = hasMergedBlocks
            }
            return result
        } else {
            let isMovePossible = previousMatrixSnapshot?.isMovePossible()
            
            if let isMovePossible = isMovePossible, isMovePossible == false {
                self.noPossibleMove = true
            }
            return .none
        }
    }
    
    private func merge(blocks: inout [IdentifiedTile], reverse: Bool) -> Bool {
        var hasMerged: Bool = false
        if reverse {
            blocks = blocks.reversed()
        }
        
        blocks = blocks
            .map { (false, $0) }
            .reduce([(Bool, IdentifiedTile)]()) { acc, item in
                if acc.last?.0 == false && acc.last?.1.value == item.1.value {
                    var accPrefix = Array(acc.dropLast())
                    var mergedBlock = item.1
                    mergedBlock.value *= 2
                    accPrefix.append((true, mergedBlock))
                    
                    self.mergeMultiplier += self.mergeMultiplierStep
                    self.score += (self.mergeMultiplier * mergedBlock.value)
                    hasMerged = true
                    
                    return accPrefix
                } else {
                    var accTmp = acc
                    accTmp.append((false, item.1))
                    return accTmp
                }
            }
            .map { $0.1 }
        
        if reverse {
            blocks = blocks.reversed()
        }
        return hasMerged
    }
    
    private func reset(boardSize: Int) {
        self.boardSize = boardSize
        tileMatrix = TileMatrixType(size: boardSize)
        resetLastGestureDirection()
        generateBlocks(generator: .double)
        score = 0
        mergeMultiplier = 0
        objectWillChange.send(self)
    }
    
    private enum TileGenerator {
        case single
        case double
    }
    
    @discardableResult
    private func generateBlocks(generator: TileGenerator) -> Bool {
        var blankLocations = [IndexPair]()
        
        for rowIndex in 0..<boardSize {
            for colIndex in 0..<boardSize {
                let index = (colIndex, rowIndex)
                
                if tileMatrix[index] == nil {
                    blankLocations.append(index)
                }
            }
        }

        defer {
            objectWillChange.send(self)
        }
                
        switch generator {
        case .single:
            return generateBlock(in: blankLocations)
        case .double:
            return generateBlockPair(in: blankLocations)
        }
    }
    
    private func generateBlock(in blankLocations: [IndexPair]) -> Bool {
        guard blankLocations.count >= 1 else {
            return false
        }
        let placeLocIndex = Int.random(in: 0..<blankLocations.count)
        tileMatrix.add(IdentifiedTile(id: mutableInstanceId,
                                        value: (((0...4).randomElement() ?? 0) == 0) ? 4 : 2),
                         to: blankLocations[placeLocIndex])
        return true
    }
    
    private func generateBlockPair(in blankLocations: [IndexPair]) -> Bool {
        guard generateBlock(in: blankLocations) else {
            return false
        }
        guard let lastLoc = blankLocations.last else {
            return false
        }
        
        var placeLocIndex = Int.random(in: 0..<blankLocations.count)
        var blankLocations = blankLocations
        blankLocations[placeLocIndex] = lastLoc
        placeLocIndex = Int.random(in: 0..<(blankLocations.count - 1))
        tileMatrix.add(
            IdentifiedTile(
                id: mutableInstanceId,
                value: 2),
            to: blankLocations[placeLocIndex]
        )
        return true
    }
}

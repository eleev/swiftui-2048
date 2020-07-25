//
//  TileMatrix.swift
//  T2iles
//
//  Created by Astemir Eleev on 03.05.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import SwiftUI

struct TileMatrix<T>: CustomStringConvertible, CustomDebugStringConvertible where T: Tile {
    
    // MARK: - Conformance to CustomStringConvertible and CustomDebugStringConvertible protocols
    
    var description: String {
        commonDescription
    }
    var debugDescription: String {
        commonDescription
    }
    
    private var commonDescription: String {
        matrix.map { row -> String in
            row.map {
                if $0 == nil {
                    return " "
                } else {
                    guard let value = $0?.value else {
                        return "?"
                    }
                    return String(describing: value)
                }
            }.joined(separator: "\t")
        }.joined(separator: "\n")
    }
    
    // MARK: - Properties
    
    
    private(set) var matrix: [[T?]]
    private let size: Int
    
    // MARK: - Initializers
    
    init(size: Int = 4) {
        self.size = size
        
        matrix = [[T?]]()
        for _ in 0..<size {
            var row = [T?]()
            for _ in 0..<size {
                row += [nil]
            }
            matrix += [row]
        }
    }
    
    // MARK: Subscripts
    
    subscript(index: IndexPair) -> T? {
        guard isValid(index: index) else { return nil }
        return matrix[index.1][index.0]
    }
    
    // MARK: - Methods
    
    mutating func add(_ tile: T?, to: IndexPair) {
        matrix[to.1][to.0] = tile
    }
    
    mutating func move(from: IndexPair, to: IndexPair, with value: T.Value) {
        move(from: from, to: to, sourceReplacement: { value })
    }
    
    mutating func move(from: IndexPair, to: IndexPair) {
       move(from: from, to: to, sourceReplacement: nil)
    }
    
    func flatten() -> [IndexedTile<T>] {
        matrix.enumerated().flatMap { (y: Int, element: [T?]) in
            element.enumerated().compactMap { (x: Int, tile: T?) in
                guard let tile = tile else {
                    return nil
                }
                return IndexedTile(index: (x, y), tile: tile)
            }
        }
    }
    
    func equals(to matrix: TileMatrix<T>) -> Bool {
        self.matrix == matrix.matrix
    }
    
    func isMovePossible() -> Bool {
        let size = matrix.count
        var emptyTiles: Int = 0
        
        for (xindex, array) in matrix.enumerated() {
            for (yindex, _) in array.enumerated() {
                let e = matrix[xindex][yindex]
                
                if e == nil {
                    emptyTiles += 1
                }
                if xindex + 1 < size, e == matrix[xindex + 1][yindex] {
                    return true
                }
                if xindex - 1 > -1, e == matrix[xindex - 1][yindex] {
                    return true
                }
                if yindex + 1 < size, e == matrix[xindex][yindex + 1] {
                    return true
                }
                if yindex - 1 > -1, e == matrix[xindex][yindex - 1] {
                    return true
                }
            }
        }
        return emptyTiles == 0 ? false : true
    }

    // MARK: - Private Helpers
    
    private mutating func move(from: IndexPair, to: IndexPair, sourceReplacement: (() -> T.Value)?) {
        guard
            isValid(index: from) && isValid(index: to),
            var source = self[from]
            else {
                return
        }
        if let sourceReplacement = sourceReplacement {
            let value = sourceReplacement()
            source.value = value
        }
        
        matrix[to.1][to.0] = source
        matrix[from.1][from.0] = nil
    }
    
    private func isValid(index: IndexPair) -> Bool {
        guard
            index.0 >= 0 && index.0 < size,
            index.1 >= 0 && index.1 < size
            else { return false }
        return true
    }
}

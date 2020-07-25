//
//  DirectionTests.swift
//  T2ilesTests
//
//  Created by Astemir Eleev on 25.07.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import XCTest
import SwiftUI
@testable import T2iles

class DirectionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDirectionLeft() throws {
        XCTAssertEqual(Direction.left.edge, Edge.leading)
    }
    
    func testDirectionRight() throws {
        XCTAssertEqual(Direction.right.edge, Edge.trailing)
    }
    
    func testDirectionUp() throws {
        XCTAssertEqual(Direction.up.edge, Edge.top)
    }
    
    func testDirectionDown() throws {
        XCTAssertEqual(Direction.down.edge, Edge.bottom)
    }
    
    func testDirectionInvertedLeft() throws {
        XCTAssertEqual(Direction.left.invertedEdge, Edge.trailing)
    }
    
    func testDirectionInvertedRight() throws {
        XCTAssertEqual(Direction.right.invertedEdge, Edge.leading)
    }
    
    func testDirectionInvertedUp() throws {
        XCTAssertEqual(Direction.up.invertedEdge, Edge.bottom)
    }
    
    func testDirectionInvertedDown() throws {
        XCTAssertEqual(Direction.down.invertedEdge, Edge.top)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  StraycatTrendingTests.swift
//  StraycatTests
//
//  Created by Harry Twan on 16/03/2018.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import XCTest
@testable import Straycat

class StraycatTrendingTests: XCTestCase {
    
    private let timeout = 10.0
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTrendingRepo() {
        let expectation = XCTestExpectation(description: "Response should be return in \(timeout)s")
        StrayTrendingParseManager.shared.fetch { success, repos in
            
        }
        
        wait(for: [expectation], timeout: timeout)
    }
}

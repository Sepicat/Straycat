//
//  Contribution.swift
//  StraycatTests
//
//  Created by Harry Twan on 2018/9/22.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import Nimble
import XCTest
import PySwiftyRegex

@testable import Straycat

class Contribution: XCTestCase {
    
    static let AsyncTimeout: TimeInterval = 100
    
    typealias TT = Contribution
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testContribution() {
        waitUntil(timeout: TT.AsyncTimeout) { done in
            StrayContribution.shared.fetchContributions("mattt") { success, contributions in
                guard let contributions = contributions, success else {
                    fail("The result is Nil")
                    return
                }
                expect(contributions.count) > 364
                for contribution in contributions {
                    expect(contribution.color.count) > 0
                    expect(contribution.dataCount) >= 0
                    expect(contribution.date.count) > 0
                }
                done()
            }
        }
    }
}

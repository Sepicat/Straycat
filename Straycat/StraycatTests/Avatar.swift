//
//  Avatar.swift
//  StraycatTests
//
//  Created by Harry Twan on 2018/9/20.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import Nimble
import XCTest
import PySwiftyRegex

@testable import Straycat

class Avatar: XCTestCase {
    
    static let AsyncTimeout: TimeInterval = 100

    typealias TT = Avatar
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUserAvatar() {
        waitUntil(timeout: TT.AsyncTimeout) { done in
            StrayAvatar.shared.fetchAvatar("iCHAIT") { success, url in
                guard let url = url, success else {
                    fail("The result is Nil")
                    done()
                    return
                }
                done()
            }
        }
    }
}

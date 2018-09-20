//
//  Topic.swift
//  StraycatTests
//
//  Created by Harry Twan on 2018/9/20.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import Nimble
import XCTest
import PySwiftyRegex

@testable import Straycat

class Topic: XCTestCase {
    
    static let AsyncTimeout: TimeInterval = 10
    static let ItemsCount = 25
    static let TopicItemsCount = 30
    
    typealias TT = Topic
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // 测试 vim topic
    func testTopicForVim() {
        waitUntil(timeout: TT.AsyncTimeout) { done in
            StrayTopic.shared.fetchRepo(type: .vim) { success, repos in
                guard let repos = repos, success else {
                    fail("The result is Nil")
                    return
                }
                expect(repos.count).to(equal(TT.TopicItemsCount))
                for repo in repos {
                    expect(repo.fullname.count) > 0
                    expect(repo.starStr.count) > 0
                    expect(repo.language.count) >= 0
                    expect(repo.description.count) > 0
                }
                done()
            }
        }
    }
    
    // 测试任意 topic
    func testTopicForOther() {
        waitUntil(timeout: TT.AsyncTimeout) { done in
            StrayTopic.shared.fetchRepo(type: .other(name: "awesome")) { success, repos in
                guard let repos = repos, success else {
                    fail("The result is Nil")
                    return
                }
                expect(repos.count).to(equal(TT.TopicItemsCount))
                for repo in repos {
                    expect(repo.fullname.count) > 0
                    expect(repo.starStr.count) > 0
                    expect(repo.language.count) >= 0
                    expect(repo.description.count) > 0
                }
                done()
            }
        }
    }
}

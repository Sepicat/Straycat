//
//  StraycatTrendingTests.swift
//  StraycatTests
//
//  Created by Harry Twan on 16/03/2018.
//  Copyright © 2018 Harry Twan. All rights reserved.
//


import Nimble
import XCTest

@testable import Straycat

class StraycatKannaTrendingTests: XCTestCase {

    static let AsyncTimeout: TimeInterval = 10
    static let ItemsCount = 25

    typealias TT = StraycatKannaTrendingTests

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    /// 测试获取数据条目
    func testTrendingRepoItemsCount() {
        waitUntil(timeout: TT.AsyncTimeout) { done in
            StrayTrending.shared.fetchRepo(tool: .kanna) { success, repos in
                guard let repos = repos, success else {
                    fail("The result is Nil")
                    return
                }
                expect(repos.count).to(equal(TT.ItemsCount))
                done()
            }
        }
    }

    /// 测试获取数据
    func testTrendingRepoItems() {
        waitUntil(timeout: TT.AsyncTimeout) { done in
            StrayTrending.shared.fetchRepo(tool: .kanna) { (success, repos) in
                guard let repos = repos, success else {
                    fail("The result is Nil")
                    return
                }
                let repoName = repos.map { $0.fullname }.filter { $0 != "" }
                expect(repoName.count).to(equal(TT.ItemsCount),
                                          description: "The repo name avatar parser is bad!")
                let repoStar = repos.map { $0.star }.filter { $0 != 0 }
                expect(repoStar.count).to(equal(TT.ItemsCount),
                                          description: "The repo stars avatar parser is bad!")
                let repoAvatar = repos.map { $0.avatar }.filter { $0 != [] }
                expect(repoAvatar.count).to(equal(TT.ItemsCount),
                                            description: "The repo author avatar parser is bad!")
                done()
            }
        }
    }

    /// 测试图片 URL 
}

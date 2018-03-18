//
//  StrayTrendingParser.swift
//  Straycat
//
//  Created by 段昊宇 on 2018/3/16.
//  Copyright © 2018年 Harry Twan. All rights reserved.
//

import UIKit
import SwiftSoup

// MARK: - API
extension StrayTrending.Parser {
    public static func fetchHandle(_ tool: StrayParser.ParserTool, type: StrayTrending.TrendingType, html: String, completion: ([Any]?) -> Void) {
        switch tool {
        case .swiftSoup:
            StrayTrending.Parser.parserBySwiftSoup(html, type: type, completion: completion)
        }
    }
}

// MARK: - Parser
extension StrayTrending.Parser {
    static func parserBySwiftSoup(_ html: String, type: StrayTrending.TrendingType, completion: ([Any]?) -> Void) {
        switch type {
        case .repository:
            completion(StrayTrending.Parser.parserBySwiftSoupForRepository(html))
            
        case .developer:
            completion(StrayTrending.Parser.parserBySwiftSoupForDeveloper(html))
        }
    }
    
    /// Trending Repo HTML Parser
    static func parserBySwiftSoupForRepository(_ html: String) -> [StrayTrendingRepo]? {
        let begin = Date().timeIntervalSince1970
        do {
            let doc: Document = try SwiftSoup.parse(html)
            if let ol: Elements = try! doc.select("ol").attr("class", "repo-list").first()?.children() {
                let repoListHtml = ol.array()
                let repos: [StrayTrendingRepo] = repoListHtml.map {
                    element -> StrayTrendingRepo in
                    var repo = StrayTrendingRepo()
                    repo.fullname = try! element
                        .select("h3").first()?.text() ?? ""
                    repo.description = try! element
                        .select("p").first()?.attr("class", "col-9 d-inline-block text-gray m-0 pr-4").text() ?? ""
                    repo.language = try! element
                        .select("span").attr("itemprop", "programmingLanguage").array()[1].text()
                    repo.star = UInt(try! element
                        .select("a").attr("class", "muted-link d-inline-block mr-3").array()[2].text()
                        .replacingOccurrences(of: ",", with: "")) ?? 0
                    repo.forkers = UInt(try! element
                        .select("a").attr("class", "muted-link d-inline-block mr-3").array()[3].text()
                        .replacingOccurrences(of: ",", with: "")) ?? 0
                    repo.gains = try! element
                        .select("span").attr("class", "muted-link d-inline-block mr-3").array()[2].text()
                        .replacingOccurrences(of: ",", with: "")
                    return repo
                }
                let end = Date().timeIntervalSince1970
                print("trending repo parser time: \(end - begin)s")
                return repos
            }
        } catch Exception.Error(let type, let message) {
            print("\(type) -> \(message)")
            print("parser failured")
        } catch {
            print("parser unknown error, failured")
        }
        return nil
    }
    
    /// Trending Dev HTML Parser
    static func parserBySwiftSoupForDeveloper(_ html: String) -> [StrayTrendingDev]? {
        let begin = Date().timeIntervalSince1970
        do {
            let doc: Document = try SwiftSoup.parse(html)
            if let ol: Elements = try! doc.select("ol").attr("class", "list-style-none").first()?.children() {
                let devListHtml = ol.array()
                let devs: [StrayTrendingDev] = devListHtml.map {
                    element -> StrayTrendingDev in
                    var dev = StrayTrendingDev()
                    dev.avatar = try! devListHtml[0]
                        .select("img").attr("class", "rounded-1").first()?.attr("src") ?? ""
                    (dev.login, dev.nickname) = try! devListHtml[0]
                        .select("div").attr("class", "mx-2").array()[2].children().array().first?
                        .select("a").array().first?.text().splitLoginAndName() ?? ("", "")
                    dev.repoName = try! devListHtml[0].select("span").attr("class", "repo").array()[1].text()
                    return dev
                }
                let end = Date().timeIntervalSince1970
                print("trending dev parser time: \(end - begin)s")
                return devs
            }
        } catch Exception.Error(let type, let message) {
            print("\(type) -> \(message)")
            print("parser failured")
        } catch {
            print("parser unknown error, failured")
        }
        return nil
    }
}

// MARK: String Helper
extension String {
    /// split login and name: demo - "aaa(bbb)" -> ("aaa", "bbb")
    func splitLoginAndName() -> (String, String) {
        var login = ""
        var name = ""
        var isName = false
        for ch in self {
            // 过滤前置空格，间隔空格
            if ch == " " && !isName { continue }
            // 发现第一个空号转换状态
            if ch == "(" {
                isName = true
                continue
            }
            // 结束条件
            if ch == ")" && isName { break }
            isName ? name.append(ch) : login.append(ch)
        }
        return (login, name)
    }
}

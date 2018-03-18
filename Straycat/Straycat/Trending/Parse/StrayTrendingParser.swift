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
            StrayTrending.Parser.parserBySwiftSoupForDeveloper(html)
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
                    repo.fullname = try! element.select("h3").first()?.text() ?? ""
                    repo.description = try! element.select("p").first()?.attr("class", "col-9 d-inline-block text-gray m-0 pr-4").text() ?? ""
                    repo.language = try! element.select("span").attr("itemprop", "programmingLanguage").array()[1].text()
                    repo.star = UInt(try! element.select("a").attr("class", "muted-link d-inline-block mr-3").array()[2].text()
                        .replacingOccurrences(of: ",", with: "")) ?? 0
                    repo.forkers = UInt(try! element.select("a").attr("class", "muted-link d-inline-block mr-3").array()[3].text()
                        .replacingOccurrences(of: ",", with: "")) ?? 0
                    repo.gains = try! element.select("span").attr("class", "muted-link d-inline-block mr-3").array()[2].text()
                        .replacingOccurrences(of: ",", with: "")
                    return repo
                }
                let end = Date().timeIntervalSince1970
                print("parser time: \(end - begin)s")
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
    
    static func parserBySwiftSoupForDeveloper(_ html: String) {
        
    }
}

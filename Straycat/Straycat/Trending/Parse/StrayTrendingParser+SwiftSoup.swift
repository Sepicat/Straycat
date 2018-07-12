//
//  StrayTrendingParser+SwiftSoup.swift
//  Straycat
//
//  Created by Harry Twan on 26/03/2018.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import UIKit
import SwiftSoup

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
    static func parserBySwiftSoupForRepository(_ html: String) -> [StrayRepo]? {
        let begin = Date().timeIntervalSince1970
        do {
            let doc: Document = try SwiftSoup.parse(html)
            if let ol: Elements = try! doc.select("ol").attr("class", "repo-list").first()?.children() {
                let repoListHtml = ol.array()
                let repos: [StrayRepo] = repoListHtml.map {
                    element -> StrayRepo in
                    var repo = StrayRepo()
                    repo.fullname = try! element
                        .select("h3").first()?.text() ?? ""
                    
                    repo.description = try! element
                        .select("p").first()?.attr("class", "col-9 d-inline-block text-gray m-0 pr-4").text() ?? ""
                    
                    // language 数据
                    do {
                        if let languageSpanTags = try? element.select("span").attr("itemprop", "programmingLanguage").array(),
                            languageSpanTags.count >= 2 {
                            repo.language = try languageSpanTags[1].text()
                        }
                    }
                    catch { }
                    
                    if repo.language.hasPrefix("Built") ||
                        repo.language.hasSuffix("today") {
                        repo.language = "unknown"
                    }
                    
                    // star & forkers 数据
                    do {
                        if let aTags = try? element.select("a").attr("class", "muted-link d-inline-block mr-3").array(),
                            aTags.count >= 4 {
                            repo.star = UInt(try aTags[2].text()
                                .replacingOccurrences(of: ",", with: "")) ?? 0
                            repo.forkers = UInt(try aTags[3].text()
                                .replacingOccurrences(of: ",", with: "")) ?? 0
                        }
                    }
                    catch {}
                    
                    // gains 数据
                    do {
                        if let spanTags = try? element.select("span").attr("class", "muted-link d-inline-block mr-3").array(),
                            spanTags.count >= 3 {
                            repo.gains = try spanTags[2].text()
                                .replacingOccurrences(of: ",", with: "")
                        }
                    }
                    catch {}
                    
                    return repo
                }
                let end = Date().timeIntervalSince1970
                print("SwiftSoup: trending repo parser time: \(end - begin)s")
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
    static func parserBySwiftSoupForDeveloper(_ html: String) -> [StrayDev]? {
        let begin = Date().timeIntervalSince1970
        do {
            let doc: Document = try SwiftSoup.parse(html)
            if let ol: Elements = try! doc.select("ol").attr("class", "list-style-none").first()?.children() {
                let devListHtml = ol.array()
                let devs: [StrayDev] = devListHtml.map {
                    element -> StrayDev in
                    var dev = StrayDev()
                    dev.avatar = try! element
                        .select("img").attr("class", "rounded-1").first()?.attr("src") ?? ""
                    (dev.login, dev.nickname) = try! element
                        .select("div").attr("class", "mx-2").array()[2].children().array().first?
                        .select("a").array().first?.text().splitLoginAndName() ?? ("", "")
                    dev.repoName = try! element.select("span").attr("class", "repo").array()[1].text()
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
            if (ch == " " || ch == "\n") && !isName { continue }
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

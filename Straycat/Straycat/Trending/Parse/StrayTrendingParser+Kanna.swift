//
//  StrayTrendingParser+Kanna.swift
//  Straycat
//
//  Created by Harry Twan on 26/03/2018.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import UIKit
import Kanna

// MARK: - Parser
extension StrayTrending.Parser {
    /// Entrance For Parser
    static func parserByKanna(_ html: String, type: StrayTrending.TrendingType, completion: ([Any]?) -> Void) {
        switch type {
        case .repository:
            completion(StrayTrending.Parser.parserByKannaForRepository(html))
        case .developer:
            completion(StrayTrending.Parser.parserByKannaForDeveloper(html))
        }
    }
    
    /// Trending Repo HTML Parser
    static func parserByKannaForRepository(_ html: String) -> [StrayTrendingRepo]? {
        // the timestamp for parser begin
        let begin = Date().timeIntervalSince1970
        
        if let doc = try? HTML(html: html, encoding: .utf8) {
            if  let ol = doc.at_xpath("//ol", namespaces: ["class": "repo-list"])?.toHTML,
                let repoListHtml = try? HTML(html: ol, encoding: .utf8)
                    .xpath("//li", namespaces: ["class": "col-12 d-block width-full py-4 border-bottom"]) {
                var ans: [StrayTrendingRepo] = []
                for repo in repoListHtml {
                    guard let repoHTMLStr = repo.toHTML else { continue }
                    if let repoHTML = try? HTML(html: repoHTMLStr, encoding: .utf8) {
                        var _repo = StrayTrendingRepo()
                        if let fullname = repoHTML.at_xpath("//a")?.text {
                            _repo.fullname = fullname.trimEmptyCharactor()
                        }
                        
                        // 获取语言
                        let spanTags = repoHTML.xpath("//span")
                        if spanTags.count >= 2 {
                            if let language = spanTags[1].text {
                                _repo.language = language.trimFirstAndLastEmptyCharactor()
                                // 纠正处理
                                if _repo.language == "Built by" ||
                                    _repo.language.hasSuffix("today") {
                                    _repo.language = "unknown"
                                }
                            }
                        } else {
                            _repo.language = "unknown"
                        }
                        
                        if let introduction = repoHTML.at_xpath("//p")?.text {
                            _repo.description = introduction.trimFirstAndLastEmptyCharactor()
                        }
                        
                        // 双策略（这里很迷，和机型有关）
                        // 由于 Tags 数量有问题，所以轮训一下所有相邻标签来判断合法性
                        let aTags = repoHTML.xpath("//div//a")
                        var starsIndex = 1
                        var forksIndex = 2
                        while aTags.count > starsIndex && aTags.count > forksIndex {
                            if let stars = aTags[starsIndex].text {
                                let starsStr = stars.trimFirstAndLastEmptyCharactor().replacingOccurrences(of: ",", with: "")
                                _repo.star = UInt(starsStr) ?? 0
                            }
                            if let forkers = aTags[forksIndex].text {
                                let forkers = forkers.trimFirstAndLastEmptyCharactor().replacingOccurrences(of: ",", with: "")
                                _repo.forkers = UInt(forkers) ?? 0
                            }
                            if _repo.star != 0 && _repo.forkers != 0 { break }
                            starsIndex += 1
                            forksIndex += 1
                        }
                        ans.append(_repo)
                    }
                }
                let end = Date().timeIntervalSince1970
                print("Kanna: trending repo parser time: \(end - begin)s")
                return ans
            }
        }
        return nil
    }
    
    /// Trending Dev HTML Parser
    static func parserByKannaForDeveloper(_ html: String) -> [StrayTrendingDev]? {
        // the timestamp for parser begin
        let begin = Date().timeIntervalSince1970
        if let doc = try? HTML(html: html, encoding: .utf8) {
            if  let ol = doc.at_xpath("//ol", namespaces: ["class": "list-style-none"])?.toHTML,
                let devListHtml = try? HTML(html: ol, encoding: .utf8)
                    .xpath("//li", namespaces: ["class": "d-sm-flex flex-justify-between border-bottom border-gray-light py-3"]) {
                var ans: [StrayTrendingDev] = []
                for dev in devListHtml {
                    guard let devHTMLStr = dev.toHTML else { continue }
                    if let devHTML = try? HTML(html: devHTMLStr, encoding: .utf8) {
                        var dev = StrayTrendingDev()
                        // 下标偏移量
                        var indexOffset = 0
                        if  let avatarUrl = devHTML.at_xpath("//img"),
                            let urlStr = avatarUrl["src"] {
                            dev.avatar = urlStr
                        }
                        if let userInfo = devHTML.at_xpath("//h2")?.text {
                            let (login, name) = userInfo.splitLoginAndName()
                            dev.login = login
                            dev.nickname = name
                            if name != "" {
                                indexOffset = 1
                            }
                        }
                        if let repoName = devHTML.xpath("//span")[1 + indexOffset].text {
                            dev.repoName = repoName.trimFirstAndLastEmptyCharactor()
                        }
                        if let repoDescription = devHTML.xpath("//span")[2 + indexOffset].text {
                            dev.repoDescription = repoDescription.trimFirstAndLastEmptyCharactor()
                        }
                        ans.append(dev)
                    }
                }
                let end = Date().timeIntervalSince1970
                print("Kanna: trending dev parser time: \(end - begin)s")
                return ans
            }
        }
        return nil
    }
}

fileprivate extension String {
    func trimEmptyCharactor() -> String {
        var fullname = self
        fullname = fullname.replacingOccurrences(of: " ", with: "")
        fullname = fullname.replacingOccurrences(of: "\n", with: "")
        return fullname
    }
    
    func trimFirstAndLastEmptyCharactor() -> String {
        let str = self
        let trimmedString = str.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedString
    }
}

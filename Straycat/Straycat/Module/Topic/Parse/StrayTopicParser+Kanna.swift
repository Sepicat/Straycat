//
//  StrayTopicParser+Kanna.swift
//  Straycat
//
//  Created by Harry Twan on 2018/9/20.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import UIKit
import Kanna

extension StrayTopic.Parser: KannaParser {
    
    /// Topic Repo HTML Parser
    public func parser(forRepo html: String) -> [StrayRepo]? {
        // the timestamp for parser begin
//        let begin = Date().timeIntervalSince1970
        
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            let articles = doc.xpath("//article")
            var ans: [StrayRepo] = []
            for article in articles {
                var _repo = StrayRepo()
                if let fullname = article.at_xpath(".//h3")?.text {
                    _repo.fullname = fullname.trimEmptyCharactor()
                }
                if let desc = article.at_xpath(".//div[@class='text-gray mb-3 ws-normal']")?.text {
                    _repo.description = desc.trimEmptyCharactor()
                }
                if let stars = article.at_xpath(".//a[@class='d-inline-block link-gray']")?.text {
                    _repo.starStr = stars.trimEmptyCharactor()
                }
                if let language = article.at_xpath(".//div/span/span[@itemprop='programmingLanguage']")?.text {
                    _repo.language = language.trimEmptyCharactor()
                }
                ans.append(_repo)
            }
            return ans
        } catch let error {
            print(error.localizedDescription)
        }
        return []
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


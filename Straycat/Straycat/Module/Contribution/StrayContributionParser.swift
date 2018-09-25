//
//  StrayContributionParser.swift
//  Straycat
//
//  Created by Harry Twan on 2018/9/22.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import UIKit
import Kanna

extension StrayContribution.Parser {
    public static func fetchHandle(_ tool: StrayParser.ParserTool,
                                   html: String,
                                   completion: ([StrayContributionModel]?) -> Void) {
        switch tool {
        case .kanna:
            completion(StrayContribution.Parser().parser(html))
        default:
            break
        }
    }
}

extension StrayContribution.Parser {
    
    private func parser(_ html: String) -> [StrayContributionModel]? {
        do {
            let doc = try XML(xml: html, encoding: .utf8)
            let rects = doc.xpath("//rect")
            var res: [StrayContributionModel] = []
            for index in 0 ..< rects.count {
                let rect = rects[index]
                let contribution = StrayContributionModel()
                contribution.color = rect["fill"] ?? ""
                contribution.date = rect["data-date"] ?? ""
                contribution.dataCount = UInt(rect["data-count"] ?? "0") ?? 0
                res.append(contribution)
            }
            var dict = [String: Int]()
            for data in res {
                dict[data.color] = 1
            }
            print(dict.keys.sorted())
            return res
        } catch let error {
            print(error.localizedDescription)
        }
        return []
    }
}

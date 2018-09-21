//
//  StrayTrendingParser.swift
//  Straycat
//
//  Created by 段昊宇 on 2018/3/16.
//  Copyright © 2018年 Harry Twan. All rights reserved.
//

import UIKit

// MARK: - API
extension StrayTrending.Parser {
    public static func fetchHandle(_ tool: StrayParser.ParserTool, type: StrayTrending.TrendingType, html: String, completion: ([Any]?) -> Void) {
        switch tool {
        case .swiftSoup:
            StrayTrending.Parser.parserBySwiftSoup(html, type: type, completion: completion)
        case .kanna:
            StrayTrending.Parser.parserByKanna(html, type: type, completion: completion)
        }
    }
}



//
//  StrayTopicParser.swift
//  Straycat
//
//  Created by Harry Twan on 2018/9/20.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import UIKit

extension StrayTopic.Parser {
    public static func fetchHandle(_ tool: StrayParser.ParserTool,
                                   type: StrayTopic.TopicType,
                                   html: String,
                                   completion: ([Any]?) -> Void) {
        switch tool {
        case .kanna:
            let repos = StrayTopic.Parser().parser(forRepo: html)
            completion(repos)
        default:
            break
        }
    }
    
}

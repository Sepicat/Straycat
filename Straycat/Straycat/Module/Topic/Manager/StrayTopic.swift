//
//  StrayTopic.swift
//  Straycat
//
//  Created by Harry Twan on 2018/9/20.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import UIKit
import Alamofire

public class StrayTopic: NSObject {
    
    public enum TopicType {
        /// Topic: https://github.com/topics/vim
        case vim
        case other(name: String)
    }
    
    class Parser: StrayParser {}
    
    public static let shared = StrayTopic()
}

extension StrayTopic.TopicType {
    func fetchUrl() -> String {
        switch self {
        case .vim:
            return "https://github.com/topics/vim"
        case .other(let name):
            return "https://github.com/topics/\(name)"
        }
    }
}

extension StrayTopic {
    /// 获取 Topic 列表信息
    public func fetchRepo(tool: StrayParser.ParserTool = .kanna,
                          header: [String: String]? = nil,
                          type: TopicType,
                          completion: @escaping (Bool, [StrayRepo]?) -> Void) {
        guard let url = URL(string: type.fetchUrl()) else {
            return
        }
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .responseString(queue: nil, encoding: .utf8) { response in
                switch response.result {
                case .success(let data):
                    StrayTopic.Parser.fetchHandle(tool, type: type, html: data) {
                        completion(true, $0 as? [StrayRepo])
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}

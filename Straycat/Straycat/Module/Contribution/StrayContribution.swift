//
//  StrayContribution.swift
//  Straycat
//
//  Created by Harry Twan on 2018/9/22.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import UIKit
import Alamofire

public class StrayContribution: NSObject {
    
    static let baseUrl = "https://github.com/users/%@/contributions"
    
    class Parser: StrayParser {}
    
    public static let shared = StrayContribution()
}

extension StrayContribution {
    
    public func fetchContributions(_ login: String,
                                   tool: StrayParser.ParserTool = .kanna,
                                   header: [String: String]? = nil,
                                   completion: @escaping (Bool, [StrayContributionModel]?) -> Void) {
        guard let url = URL(string: String(format: StrayContribution.baseUrl, login)) else {
            return
        }
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .responseString(queue: nil, encoding: .utf8) { response in
                switch response.result {
                case .success(let data):
                    StrayContribution.Parser.fetchHandle(tool, html: data) { contributions in
                        guard let contributions = contributions else {
                            completion(false, nil)
                            return
                        }
                        completion(true, contributions)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false, nil)
                }
        }
    }
}



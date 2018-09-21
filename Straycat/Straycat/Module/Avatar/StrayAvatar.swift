//
//  StrayAvatar.swift
//  Straycat
//
//  Created by Harry Twan on 2018/9/20.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import UIKit
import Alamofire
import Kanna
import PySwiftyRegex

public class StrayAvatar: NSObject {
    public static let shared = StrayAvatar()
    
    public private(set) var cache = Dictionary<String, String>(minimumCapacity: 1000)
}

extension StrayAvatar {
    public func fetchAvatar(_ login: String,
                            header: [String: String]? = nil,
                            completion: @escaping (Bool, String?) -> Void) {
        if let cacheRes = cache[login] {
            completion(true, cacheRes)
            return
        }
        guard let url = URL(string: "https://github.com/\(login)") else {
            completion(false, nil)
            return
        }
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .responseString(queue: nil, encoding: .utf8) { response in
                switch response.result {
                case .success(let data):
                    guard let avatar = self.parserAvatar(data) else {
                        completion(false, nil)
                        return
                    }
                    completion(true, avatar)
                    self.cache[login] = avatar
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false, nil)
                }
        }
    }
    
    private func parserAvatar(_ html: String) -> String? {
        // Kanna 有一些问题先使用正则
        if let m = re.search("https://avatars.*\\.com/u/[0-9]{1,10}\\?s=[0-9]{3}", html) {
            if let login = m.group() {
                return login
            }
        }
        return nil
    }
}

//
//  StrayTrendingParseManager.swift
//  Straycat
//
//  Created by Harry Twan on 16/03/2018.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import UIKit
import Alamofire

public class StrayTrending: NSObject {
    
    /// Trending 种类
    public enum TrendingType {
        /// Repo: https://github.com/trending
        case repository
        /// Repo: https://github.com/trending/developers
        case developer
    }
    
    /// 筛选 Item
    public enum TrendingTimeRange: String {
        /// today
        case today = "daily"
        /// this week
        case thisWeek = "weekly"
        /// this month
        case thisMonth = "monthly"
    }
    
    /// 仅做声明
    class Parser: StrayParser {}
    
    public static let shared = StrayTrending()
}

extension StrayTrending {
    /// 获取 Trending Repo 信息
    public func fetch(_ type: TrendingType = .repository,
                      language: String = "all",
                      time: TrendingTimeRange = .today,
                      completion: @escaping (Bool, [StrayTrendingRepo]?) -> Void) {
        guard let url = URL(string: "https://github.com/trending") else {
            return
        }
        Alamofire.request(url).responseString(queue: nil, encoding: .utf8) {
            response in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

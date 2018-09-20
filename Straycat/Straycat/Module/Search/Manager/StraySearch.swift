//
//  StraySearch.swift
//  Straycat
//
//  Created by Harry Twan on 2018/7/5.
//  Copyright © 2018年 Harry Twan. All rights reserved.
//

import UIKit

class StraySearch: NSObject {
    
    /// Search 种类
    public enum SearchType {
        /// 排名
        case rank(SearchCountry)
    }
    
    /// Search 国家
    public enum SearchCountry {
        /// 中国
        case cn
        /// 美国
        case us
        /// 日本
        case jp
        /// 印度
        case ind
    }
    
    public static let shared = StraySearch()
}

extension StraySearch {
    /// 获取 Search 信息
    
}

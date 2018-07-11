//
//  StrayTrendingModel.swift
//  Straycat
//
//  Created by Harry Twan on 16/03/2018.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import UIKit

/// Trending Repo Model
public struct StrayRepo {
    public var language: String = ""
    public var fullname: String = ""
    public var description: String = ""
    public var star: UInt = 0
    public var forkers: UInt = 0
    public var gains: String = ""
}

/// Trending Dev Model
public struct StrayDev {
    public var avatar: String = ""
    public var login: String = ""
    public var nickname: String = ""
    public var repoName: String = ""
    public var repoDescription: String = ""
}

/// Analysis
public struct StrayUserAnalysis {
    
    public struct User {
        public var hireable: Bool
        public var createdAt: UInt
    }
}

//
//  StrayTrendingModel.swift
//  Straycat
//
//  Created by Harry Twan on 16/03/2018.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import UIKit

/// Trending Repo Model
public struct StrayTrendingRepo {
    var language: String = ""
    var fullname: String = ""
    var description: String = ""
    var star: UInt = 0
    var forkers: UInt = 0
    var gains: String = ""
}

/// Trending Dev Model
public struct StrayTrendingDev {
    var login: String = ""
    var nickname: String = ""
    var repoName: String = ""
    var repoDescription: Strin = ""
}

//
//  StrayAnalysisModel.swift
//  Straycat
//
//  Created by Harry Twan on 2018/7/12.
//  Copyright © 2018年 Harry Twan. All rights reserved.
//

import UIKit

/// Analysis
public class StrayUserAnalysis: Decodable {
    
    // User 信息
    public class User: Codable {
        public var hireable: Bool = false
        public var createdAt: UInt = 0
        public var collaborators: UInt = 0
        public var diskUsage: UInt = 0
        public var followers: UInt = 0
        public var following: UInt = 0
        public var id: UInt = 0
        public var ownedPrivateRepos: UInt = 0
        public var privateGists: UInt = 0
        public var publicGists: UInt = 0
        public var publicRepos: UInt = 0
        public var totalPrivateRepos: UInt = 0
        public var avatarUrl: String = ""
        public var blog: String = ""
        public var company: String = ""
        public var email: String = ""
        public var gravatarId: String = ""
        public var htmlUrl: String = ""
        public var location: String = ""
        public var login: String = ""
        public var name: String = ""
        public var type: String = ""
        public var url: String = ""
    }
    
    // 季度 Commit 统计
    public class CommitTrend: Codable {
        public var quarter: String = ""
        public var commitCount: UInt = 0
    }
    
    // 仓库语言统计
    
    public var user: User = User()
    public var quarterCommitCount: [String: Int] = [:]
    
    enum CodingKeys: String, CodingKey {
        case user = "user"
        case quarterCommitCount = "quarterCommitCount"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let user = try values.decode(User.self, forKey: .user)
        let qcc = try values.decode(Dictionary<String, Int>.self, forKey: .quarterCommitCount)
        self.user = user
        self.quarterCommitCount = qcc
    }
}

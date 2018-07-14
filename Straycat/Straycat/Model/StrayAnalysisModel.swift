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
    public class CommitTrend {
        public var quarter: String = ""
        public var commitCount: UInt = 0
        
        init(quarter: String, commitCount: UInt) {
            self.quarter = quarter
            self.commitCount = commitCount
        }
    }
    
    // 仓库
    public class Repository {
        private(set) var name: String = ""
        private(set) var description: String? = nil
        private(set) var starCount: UInt? = nil
        private(set) var language: String? = nil
        
        init(name: String, desc: String? = nil, starCount: UInt? = nil, language: String? = nil) {
            self.name = name
            self.description = desc
            self.starCount = starCount
            self.language = language
        }
    }
    
    // 语言
    public class Language {
        private(set) var name: String = ""
        private(set) var commitCount: UInt? = nil
        private(set) var starCount: UInt? = nil
        private(set) var repoCount: UInt? = nil
        
        init(name: String, commitCount: UInt? = nil, starCount: UInt? = nil, repoCount: UInt? = nil) {
            self.name = name
            self.commitCount = commitCount
            self.starCount = starCount
            self.repoCount = repoCount
        }
    }
    
    // 仓库语言统计
    public var user: User = User()
    public var quarterCommitCount: [CommitTrend] = []
    public var topStarRepos: [Repository] = []
    public var commitLanguageCount: [Language] = []

    enum CodingKeys: String, CodingKey {
        case user = "user"
        case quarterCommitCount = "quarterCommitCount"
        case repoStarCount = "repoStarCount"
        case repoStarCountDescriptions = "repoStarCountDescriptions"
        case langCommitCount = "langCommitCount"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let user = try values.decode(User.self, forKey: .user)
        let qcc = try values.decode(Dictionary<String, UInt>.self, forKey: .quarterCommitCount)
        let rsc = try values.decode(Dictionary<String, UInt>.self, forKey: .repoStarCount)
        let rscd = try values.decode(Dictionary<String, String>.self, forKey: .repoStarCountDescriptions)
        let lcc = try values.decode(Dictionary<String, UInt>.self, forKey: .langCommitCount)
        
        // user 信息
        self.user = user
        
        // commit 季度趋势
        self.quarterCommitCount = qcc.map { CommitTrend(quarter: $0, commitCount: $1) }
        
        // 仓库 top 10
        self.topStarRepos = rsc.map { key, val -> Repository in
            let desc = rscd[key] ?? nil
            return Repository.init(name: key, desc: desc, starCount: val)
        }
        
        // 语言 Rank
        self.commitLanguageCount = lcc.map { Language(name: $0, commitCount: $1) }

    }
}

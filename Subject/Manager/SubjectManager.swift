//
//  SubjectManager.swift
//  AcknowList
//
//  Created by Harry Twan on 2018/6/21.
//

import UIKit
import Alamofire

public class SubjectManager: NSObject {
    
    public static let shared = SubjectManager()
    
    /// Subject 类型
    public enum SubjectType {
        /// Topic: https://github.com/topics/awesome?o=desc&s=stars
        case awesome
        /// Topic: https://github.com/topics/algorithm?o=desc&s=stars
        case algorithm
        
    }
}

extension SubjectManager.SubjectType {
    public var url: String {
        get {
            switch self {
            case .awesome:
                return "https://github.com/topics/awesome?o=desc&s=stars"
            case .algorithm:
                return "https://github.com/topics/algorithm?o=desc&s=stars"
            }
        }
    }
}

// MARK: - API
extension SubjectManager {
    public func fetchRepo() {
        
    }
}

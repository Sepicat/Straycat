//
//  StrayAnalysis.swift
//  Straycat
//
//  Created by Harry Twan on 2018/7/11.
//  Copyright © 2018年 Harry Twan. All rights reserved.
//

import UIKit
import Alamofire

public class StrayAnalysis: NSObject {
    
    /// Analysis 种类
    public enum AnalysisType {
        /// profile-summary-for-github
        case psfg
    }
    
    public static let shared = StrayAnalysis()
}

extension StrayAnalysis {
    
    /// 获取分析资料信息
    public func fetchUserAnalysis(type: StrayAnalysis.AnalysisType,
                                  login: String,
                                  header: [String: String]? = nil,
                                  completion: @escaping (Bool, StrayUserAnalysis?) -> Void) {
        guard let url = URL(string: "https://profile-summary-for-github.com/api/user/\(login)") else {
            completion(false, nil)
            return
        }
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .responseData { response in
                guard let data = response.data else {
                    completion(false, nil)
                    return
                }
                do {
                    let userAnalysis = try JSONDecoder().decode(StrayUserAnalysis.self, from: data)
                    completion(true, userAnalysis)
                } catch(let exception) {
                    print("StrayAnalysis: \(exception.localizedDescription)")
                    completion(false, nil)
                }
        }
    }
}

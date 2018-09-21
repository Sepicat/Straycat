//
//  StrayParser.swift
//  Straycat
//
//  Created by 段昊宇 on 2018/3/17.
//  Copyright © 2018年 Harry Twan. All rights reserved.
//

import UIKit

public class StrayParser: NSObject {
    
    public enum ParserTool {
        case swiftSoup
        case kanna
    }
}

public protocol KannaParser {
    /// 爬取仓库方法
    func parser(forRepo html: String) -> [StrayRepo]?
    
    /// 爬取用户方案
    func parser(forUser html: String) -> [StrayDev]?
}

extension KannaParser {
    func parser(forRepo html: String) -> [StrayRepo]? {
        return nil
    }
    
    func parser(forUser html: String) -> [StrayDev]? {
        return nil
    }
}

//
//  StrayContributionModel.swift
//  Straycat
//
//  Created by Harry Twan on 2018/9/22.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import UIKit

public class StrayContributionModel: NSObject {
    public var date = ""
    public var color = ""
    public var dataCount: UInt = 0
    
    private var levelCache: Int = -1

    public var level: Int {
        get {
            if levelCache != -1 { return levelCache }
            switch color {
            case "#ebedf0": levelCache = 0
            case "#c6e48b": levelCache = 1
            case "#7bc96f": levelCache = 2
            case "#239a3b": levelCache = 3
            case "#196127": levelCache =  4
            default: return -1
            }
            return levelCache
        }
    }
    
    public var dater: Date? {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-HH-dd"
            return formatter.date(from: date)
        }
    }
}

public class StrayContributionAnalysis: NSObject {
    
    internal let datas: [StrayContributionModel]
    
    /// 总 contribution
    public private(set) var total: UInt = 0
    
    /// 平均每天贡献
    public private(set) var average: Double = 0
    
    /// 最长连续天数
    public private(set) var keepDays: UInt = 0
    
    /// start day
    public private(set) var startDay: Date = Date()
    
    /// end day
    public private(set) var endDay: Date = Date()

    public init(datas: [StrayContributionModel]) {
        self.datas = datas
        super.init()
        analysis()
        print("end")
    }
    
    private func analysis() {
        total = 0
        keepDays = 0
        var currentKeepDays: UInt = 0
        for data in datas {
            total += data.dataCount
            if data.dataCount > 0 {
                currentKeepDays += 1
            } else {
                keepDays = max(currentKeepDays, keepDays)
                currentKeepDays = 0
            }
//            print("\(currentKeepDays) - data count: \(data.dataCount)")
        }
        average = Double(total) / Double(datas.count)
        if let startDay = datas.first?.dater {
            self.startDay = startDay
        }
        if let endDay = datas.last?.dater {
            self.endDay = endDay
        }
    }
}

//
//  SpiderLogger.swift
//  NetSpider
//
//  Created by 薄海硕 on 2019/6/29.
//  Copyright © 2019 David小硕. All rights reserved.
//

import UIKit

class SpiderLogger: NSObject {
    
    enum LoggerType {
        case debug
        case warnning
        case error
        case info
    }
    
    static func logPrint<T>(msg: T) {
        logPrint(msg: msg, type: .info)
    }
    
    static func logPrint<T>(msg: T, type: LoggerType) {
        #if DEBUG
        switch type {
        case .debug:
            print("🔨", terminator: "")
        case .warnning:
            print("⚠️", terminator: "")
        case .error:
            print("❌", terminator: "")
        case .info:
            print("🍭", terminator: "")
        }
        print(msg)
        #endif
    }
    
}

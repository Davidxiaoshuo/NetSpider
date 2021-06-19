//
//  SpiderLogger.swift
//  NetSpider
//
//  Created by David硕 on 2019/6/29.
//  Copyright © 2019 David‘s Studio. All rights reserved.
//

import UIKit

class SpiderLogger: NSObject {
    
    enum LoggerType {
        case debug
        case warnning
        case error
        case info
    }
    
    static func logPrint<T>(msg: T, type: LoggerType) {
        #if DEBUG
        switch type {
        case .debug:
            print("🔨 -> ", terminator: "")
        case .warnning:
            print("⚠️ -> ", terminator: "")
        case .error:
            print("❌ -> ", terminator: "")
        case .info:
            print("🍭 -> ", terminator: "")
        }
        print(msg)
        #endif
    }
    
    static func debug<T>(msg: T) {
        logPrint(msg: msg, type: .debug)
    }
    
    static func info<T>(msg: T) {
        logPrint(msg: msg, type: .info)
    }
    
    static func warnning<T>(msg: T) {
        logPrint(msg: msg, type: .warnning)
    }
    
    static func error<T>(msg: T) {
        logPrint(msg: msg, type: .error)
    }
    
}

//
//  NetSpiderDefine.swift
//  NetSpider
//
//  Created by David硕 on 2020/6/30.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import UIKit

public struct NetSpiderDefine {
    
    public typealias HTTPHeaders = [String: String]
    
    public static let kDefaultRequestTimeout: TimeInterval = 20
    public static let kDefaultRequestRetryTimes: Int = 3
    
    public enum HTTPAPIType {
        case restful
        case graphQL
    }
}

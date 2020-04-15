//
//  ApiError.swift
//  NetSpider
//
//  Created by 薄海硕 on 2019/6/29.
//  Copyright © 2019 David小硕. All rights reserved.
//

import UIKit

public enum ApiError: Error, RawRepresentable {
    
    public typealias RawValue = (code: Int, reason: String)
    
    case missUrl
    case __unknown(RawValue)
    
    public init?(rawValue: (code: Int, reason: String)) {
        let code = rawValue.code
        switch code {
        case -10001:
            self = .missUrl
        default:
            self = .__unknown(rawValue)
        }
    }
    
    public var rawValue: (code: Int, reason: String) {
        switch self {
        case .missUrl: return (-10001, "parameter wrong, url is missing")
        case .__unknown((let code, let reason)): return (code, reason)
        }
    }
   
}

public struct ApiResponsedError {
    
    public let code: Int
    public let message: String
    
    init(_ code: Int, _ message: String) {
        self.code = code
        self.message = message
    }
}

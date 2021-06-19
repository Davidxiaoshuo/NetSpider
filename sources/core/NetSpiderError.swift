//
//  ApiError.swift
//  NetSpider
//
//  Created by David硕 on 2019/6/29.
//  Copyright © 2019 David‘s Studio. All rights reserved.
//

import Foundation

public protocol NetworkError: Error {
    
    var debugDescription: String { get }
    
}

public enum APIRequestError: NetworkError, RawRepresentable {
    
    public typealias RawValue = (code: Int, reason: String)
    
    case lostURL
    case lostEndpoint
    case lostProvider
    case __unknown(RawValue)
    
    public init?(rawValue: (code: Int, reason: String)) {
        let code = rawValue.code
        switch code {
        case -10001:
            self = .lostURL
        case -10002:
            self = .lostEndpoint
        case -10003:
            self = .lostProvider
        default:
            self = .__unknown(rawValue)
        }
    }
    
    public var rawValue: (code: Int, reason: String) {
        switch self {
        case .lostURL: return (-10001, "request parameter wrong, the url is missing ~")
        case .lostEndpoint: return (-10002, "request parameter wrong, the endpoint is missing ~")
        case .lostProvider: return (-10003, "request provider wrong, the provider is missing ~")
        case .__unknown((let code, let reason)): return (code, reason)
        }
    }
    
    public var debugDescription: String {
        return self.rawValue.reason
    }
   
}

public enum APIResponseErrorCode: RawRepresentable {

    public typealias RawValue = Int
    
    case parseModelError
    case parseJSONError
    case __unknown(RawValue)
    
    public init?(rawValue: Int) {
        switch rawValue {
        case -201:
            self = .parseModelError
        case -202:
            self = .parseJSONError
        default:
            self = .__unknown(rawValue)
        }
    }
    
    public var rawValue: Int {
        switch self {
        case .parseModelError: return -201
        case .parseJSONError: return -202
        case .__unknown(let value): return value
        }
    }
}

public struct APIResponsedError: NetworkError {
    
    public let code: Int
    public let message: String
    
    init(_ code: Int, _ message: String) {
        self.code = code
        self.message = message
    }
    
    public var debugDescription: String {
        return message
    }
}

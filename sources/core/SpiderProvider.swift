//
//  SpiderProvider.swift
//  NetSpider
//
//  Created by 薄海硕 on 2019/7/1.
//  Copyright © 2019 David小硕. All rights reserved.
//

import UIKit
import Alamofire

public enum ApiPath: RawRepresentable {
    
    public typealias RawValue = String
    
    case `default`
    case __unknown(RawValue)
    
    public init?(rawValue: String) {
        switch rawValue {
        case "": self = .default
        default: self = .__unknown(rawValue)
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .default:
            return ""
        case .__unknown(let value):
            return value
        }
    }
    
}

public struct Provider {
    
    public var endpoint: String
    public var apiPath: ApiPath
    public var headers: HTTPHeaders?
    public var parameterBoby: Parameters
    public var parameterEncoder: ParameterEncoding
    
    init(endpoint: String,
         apiPath: ApiPath,
         headers: HTTPHeaders?,
         parameterBoby: Parameters,
         parameterEncoder: ParameterEncoding) {
        self.endpoint = endpoint
        self.apiPath = apiPath
        self.headers = headers
        self.parameterBoby = parameterBoby
        self.parameterEncoder = parameterEncoder
    }
}

public class SpiderProvider: NSObject {
    
    private var endpoint: String?
    private var apiPath: ApiPath?
    private var headers: HTTPHeaders?
    private var parameterBoby: Parameters?
    private var parameterEncoder: ParameterEncoding?
    
    override init() {
        super.init()
    }
    
    init(endpoint: String,
         apiPath: ApiPath,
         headers: HTTPHeaders?,
         parameterBoby: Parameters,
         parameterEncoder: ParameterEncoding) {
        self.endpoint = endpoint
        self.apiPath = apiPath
        self.headers = headers
        self.parameterBoby = parameterBoby
        self.parameterEncoder = parameterEncoder
        super.init()
    }
    
    func withEndpoint(endpoint: String) -> SpiderProvider {
        self.endpoint = endpoint
        return self
    }
    
    func withApiPath(apiPath: ApiPath) -> SpiderProvider {
        self.apiPath = apiPath
        return self
    }
    
    func withHeads(headers: HTTPHeaders) -> SpiderProvider {
        self.headers = headers
        return self
    }
    
    func withParameter(parameter: Parameters) -> SpiderProvider {
        self.parameterBoby = parameter
        return self
    }
    
    func withParameterEncoder(encoding: ParameterEncoding) -> SpiderProvider {
        self.parameterEncoder = encoding
        return self
    }
    
    func build() throws -> Provider {
        guard let endpoint = self.endpoint, "" == endpoint else {
            throw ApiError.__unknown((-10001, "provider's endpoint is nil"))
        }
        guard let apiPath = self.apiPath else {
            throw ApiError.__unknown((-10001, "provider's apiPath is nil"))
        }
        guard let params = parameterBoby else {
            throw ApiError.__unknown((-10001, "provider's parameterBoby is nil"))
        }
        guard let encoding = parameterEncoder else {
            throw ApiError.__unknown((-10001, "provider's parameterEncoder is nil"))
        }
        
        return Provider.init(endpoint: endpoint, apiPath: apiPath, headers: headers, parameterBoby: params, parameterEncoder: encoding)
    }
    
}

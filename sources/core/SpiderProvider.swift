//
//  SpiderProvider.swift
//  NetSpider
//
//  Created by 薄海硕 on 2019/7/1.
//  Copyright © 2019 David小硕. All rights reserved.
//

import UIKit
import Alamofire

public enum Endpoint: RawRepresentable {
    
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

public struct RestfulRequestProvider: ProviderProtocol {
    
    public var httpProtocol: NetSpiderDefine.HttpProtocol = .restful
    
    public var endpoint: Endpoint
    public var hostURL: String
    public var headers: HTTPHeaders?
    public var method: NetSpiderDefine.HttpMethod
    public var parameterBoby: Parameters
    public var parameterEncoder: ParameterEncoding
    
    init(hostURL: String,
         endpoint: Endpoint,
         method: NetSpiderDefine.HttpMethod,
         headers: HTTPHeaders?,
         parameterBoby: Parameters,
         parameterEncoder: ParameterEncoding) {
        self.endpoint = endpoint
        self.hostURL = hostURL
        self.method = method
        self.headers = headers
        self.parameterBoby = parameterBoby
        self.parameterEncoder = parameterEncoder
    }
}

public class RestfulRequestBuilder: RequestBuilder {
    
    public typealias Provider = RestfulRequestProvider
    
    private var hostURL: String?
    private var endpoint: Endpoint?
    private var method: NetSpiderDefine.HttpMethod = .get
    private var headers: HTTPHeaders?
    private var parameterBoby: Parameters?
    private var parameterEncoder: ParameterEncoding?
    
    init(hostURL: String,
         endpoint: Endpoint,
         method: NetSpiderDefine.HttpMethod,
         headers: HTTPHeaders?,
         parameterBoby: Parameters,
         parameterEncoder: ParameterEncoding) {
        self.endpoint = endpoint
        self.hostURL = hostURL
        self.headers = headers
        self.parameterBoby = parameterBoby
        self.parameterEncoder = parameterEncoder
    }
    
    func with(endpoint: Endpoint) -> RestfulRequestBuilder {
        self.endpoint = endpoint
        return self
    }
    
    func with(hostURL: String) -> RestfulRequestBuilder {
        self.hostURL = hostURL
        return self
    }
    
    func with(method: NetSpiderDefine.HttpMethod) -> RestfulRequestBuilder {
        self.method = method
        return self
    }
    
    func with(headers: HTTPHeaders) -> RestfulRequestBuilder {
        self.headers = headers
        return self
    }
    
    func with(parameter: Parameters) -> RestfulRequestBuilder {
        self.parameterBoby = parameter
        return self
    }
    
    func with(encoding: ParameterEncoding) -> RestfulRequestBuilder {
        self.parameterEncoder = encoding
        return self
    }
    
    public func build() throws -> RestfulRequestProvider {
        guard let hostURL = self.hostURL, "" == hostURL else {
            throw ApiError.__unknown((-10001, "provider's endpoint is nil"))
        }
        guard let endpoint = self.endpoint else {
            throw ApiError.__unknown((-10001, "provider's apiPath is nil"))
        }
        guard let params = parameterBoby else {
            throw ApiError.__unknown((-10001, "provider's parameterBoby is nil"))
        }
        guard let encoding = parameterEncoder else {
            throw ApiError.__unknown((-10001, "provider's parameterEncoder is nil"))
        }
        
        return RestfulRequestProvider.init(
            hostURL: hostURL,
            endpoint: endpoint,
            method: method,
            headers: headers,
            parameterBoby: params,
            parameterEncoder: encoding
        )
    }
    
}

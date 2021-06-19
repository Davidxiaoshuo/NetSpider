//
//  SpiderProvider.swift
//  NetSpider
//
//  Created by David硕 on 2019/7/1.
//  Copyright © 2019 David‘s Studio. All rights reserved.
//

import UIKit
import Alamofire

public typealias Endpoint = String
public typealias Host = String

public struct RestfulRequestProvider: ProviderProtocol {
    
    public var httpProtocol: NetSpiderDefine.HTTPAPIType = .restful
    
    public var endpoint: Endpoint
    public var hostURL: Host
    public var headers: NetSpiderDefine.HTTPHeaders?
    public var method: HTTPMethod
    public var parameterBoby: Parameters
    public var parameterEncoder: ParameterEncoding
    
    init(hostURL: Host,
         endpoint: Endpoint,
         method: HTTPMethod,
         headers: NetSpiderDefine.HTTPHeaders?,
         parameterBoby: Parameters,
         parameterEncoder: ParameterEncoding
    ) {
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
    
    private var hostURL: Host?
    private var endpoint: Endpoint?
    private var method: HTTPMethod = .get
    private var headers: NetSpiderDefine.HTTPHeaders = [: ]
    private var parameterBoby: Parameters = [: ]
    private var parameterEncoder: ParameterEncoding = URLEncoding.default
    
    init() {
    }
    
    init(hostURL: Host? = nil,
         endpoint: Endpoint,
         method: HTTPMethod,
         headers: NetSpiderDefine.HTTPHeaders = [: ],
         parameterBoby: Parameters = [: ],
         parameterEncoder: ParameterEncoding = URLEncoding.default
    ) {
        self.endpoint = endpoint
        self.hostURL = hostURL
        self.headers = headers
        self.parameterBoby = parameterBoby
        self.parameterEncoder = parameterEncoder
    }
    
    func with(endpoint: Endpoint) -> Self {
        self.endpoint = endpoint
        return self
    }
    
    func with(hostURL: Host) -> Self {
        self.hostURL = hostURL
        return self
    }
    
    func with(method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    func with(headers: NetSpiderDefine.HTTPHeaders) -> Self {
        self.headers = headers
        return self
    }
    
    @discardableResult
    func add(headers: NetSpiderDefine.HTTPHeaders) -> Self {
        self.headers.append(other: headers)
        return self
    }
    
    func with(parameters: Parameters) -> Self {
        self.parameterBoby = parameters
        return self
    }
    
    @discardableResult
    func add(parameters: Parameters) -> Self {
        self.parameterBoby.append(other: parameters)
        return self
    }
    
    func with(encoding: ParameterEncoding) -> Self {
        self.parameterEncoder = encoding
        return self
    }
    
    public func build() throws -> RestfulRequestProvider {
        guard let endpoint = self.endpoint else {
            throw APIRequestError.lostEndpoint
        }
        return RestfulRequestProvider.init(
            hostURL: hostURL ?? "",
            endpoint: endpoint,
            method: method,
            headers: headers,
            parameterBoby: parameterBoby,
            parameterEncoder: parameterEncoder
        )
    }
    
}

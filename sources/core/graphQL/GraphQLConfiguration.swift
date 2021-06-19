//
//  GraphQLConfiguration.swift
//  NetSpider
//
//  Created by David硕 on 2020/11/10.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import UIKit

public struct GraphQLConfiguration: NetConfigurationProtocol {
    
    public var isNeedParseDataField: Bool = true
    
    var host: String
    var endpoint: String
    var authorityEndpoint: String
    var timeoutInterval: TimeInterval
    var retryTimes: Int
    var httpHeaders: NetSpiderDefine.HTTPHeaders
    
    init(
        host: String,
        endpoint: String,
        authorityEndpoint: String,
        httpHeaders: NetSpiderDefine.HTTPHeaders = [: ],
        timeoutInterval: TimeInterval = NetSpiderDefine.kDefaultRequestTimeout,
        retryTimes: Int = NetSpiderDefine.kDefaultRequestRetryTimes,
        isNeedParseDataField: Bool = true
    ) {
        self.host = host
        self.endpoint = endpoint
        self.authorityEndpoint = authorityEndpoint
        self.httpHeaders = httpHeaders
        self.timeoutInterval = timeoutInterval
        self.retryTimes = retryTimes
        self.isNeedParseDataField = isNeedParseDataField
    }
    
    mutating func setHost(host: String) {
        self.host = host
    }
    
    mutating func setHeaders(headers: NetSpiderDefine.HTTPHeaders) {
        self.httpHeaders = headers
    }

}

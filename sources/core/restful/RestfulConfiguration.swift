//
//  RESTfulConfiguration.swift
//  NetSpider
//
//  Created by David硕 on 2020/11/12.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import UIKit

public struct RestfulConfiguration: NetConfigurationProtocol {
    
    public var isNeedParseDataField: Bool = true

    var host: String
    var timeoutInterval: TimeInterval
    var retryTimes: Int
    var commonHeaders: NetSpiderDefine.HTTPHeaders
    
    init(
        host: String,
        commonHeaders: NetSpiderDefine.HTTPHeaders,
        timeoutInterval: TimeInterval = NetSpiderDefine.kDefaultRequestTimeout,
        retryTimes: Int = NetSpiderDefine.kDefaultRequestRetryTimes,
        isNeedParseDataField: Bool = true
    ) {
        self.host = host
        self.timeoutInterval = timeoutInterval
        self.retryTimes = retryTimes
        self.commonHeaders = commonHeaders
        self.isNeedParseDataField = isNeedParseDataField
    }
    
    mutating func setHost(host: String) {
        self.host = host
    }
    
    mutating func setCommonHeaders(headers: NetSpiderDefine.HTTPHeaders) {
        self.commonHeaders = headers
    }
    
}

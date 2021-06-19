//
//  RestfulNetworkTransport.swift
//  NetSpider
//
//  Created by David硕 on 2020/7/2.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import UIKit
import Alamofire

class RestfulNetworkTransport: NetworkTransportProtocol {
    
    typealias Configuration = RestfulConfiguration
    
    private let callbackQueue: DispatchQueue = DispatchQueue(label: "ai.studio.ios.net.spider.restful.callback.queue")
    
    var apiType: NetSpiderDefine.HTTPAPIType = .restful
    
    var netConfiguration: RestfulConfiguration
    var provider: RestfulRequestProvider?
    
    convenience init(
        netConfiguration: RestfulConfiguration,
        provider: RestfulRequestProvider
    ) {
        self.init(netConfiguration: netConfiguration)
        self.provider = provider
    }
    
    internal required init(netConfiguration: RestfulConfiguration) {
        self.netConfiguration = netConfiguration
    }
    
    func send(responseHandler: @escaping ResponseHandler) -> NetworkTask? {
        
        guard let requestProvider = provider else {
            SpiderLogger.error(msg: "RESTfulNetworkTransport --> request provider is nil")
            
            return nil
            
        }
        guard let url = self.assembleRequestURL(other: requestProvider.hostURL, endpoint: requestProvider.endpoint),
              !url.isEmpty else {
            SpiderLogger.error(msg: "RESTfulNetworkTransport --> request url is nil")
            return nil
        }
        
        let method = requestProvider.method
        let parameters = requestProvider.parameterBoby
        let endcoder = requestProvider.parameterEncoder
        let headers = self.assembleWithCommondHeaders(other: requestProvider.headers ?? [: ])
        
        let dataRequest = request(
            url,
            method: method,
            parameters: parameters,
            encoding: endcoder,
            headers: headers
        )
        .validate()
        .responseString(queue: callbackQueue) { (response) in
            switch response.result {
            case .success(_):
                responseHandler(response.request, response.response, response.data, nil)
                
            case .failure(let error):
                let statusCode = response.response?.statusCode ?? 0
                let responseError = APIResponsedError(statusCode, error.localizedDescription)
                responseHandler(response.request, response.response, nil, responseError)
            }
        }
        return dataRequest
    }
    
    func assembleWithCommondHeaders(other headers: NetSpiderDefine.HTTPHeaders) -> NetSpiderDefine.HTTPHeaders {
        var retHeaders = netConfiguration.commonHeaders
        retHeaders.append(other: headers)
        return retHeaders
    }
    
    func assembleRequestURL(other host: String, endpoint: Endpoint) -> String? {
        if host.isEmpty {
            return self.netConfiguration.host.assembleURL(with: endpoint)?.absoluteString
        } else {
            return host.assembleURL(with: endpoint)?.absoluteString
        }
    }

}

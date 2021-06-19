//
//  RESTfulClient.swift
//  NetSpider
//
//  Created by David硕 on 2020/7/30.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import UIKit
import Alamofire

class RestfulClient: NSObject {

    var netConfiguration: RestfulConfiguration
    var request: Request<RestfulNetworkTransport>?
    var task: NetworkTask?
    
    private(set) var callbackQueue: DispatchQueue = .main
    
    init(configuration: RestfulConfiguration) {
        self.netConfiguration = configuration
    }

    
    /// request
    /// - Parameters:
    ///   - callbackQueue: callback 所处线程
    ///   - requestBuilder: request parameter builder
    /// - Returns: Client
    func request(
        callbackQueue: DispatchQueue = .main,
        builder requestBuilder: RestfulRequestBuilder
    ) -> Self {
        do {
            self.callbackQueue = callbackQueue
            let provider = try requestBuilder.build()
            let transport = RestfulNetworkTransport(netConfiguration: netConfiguration, provider: provider)
            self.request = Request(transport: transport)
            return self
        } catch let error {
            SpiderLogger.error(msg: "RESTful request before occure an error, \((error as? APIRequestError)?.rawValue.reason ?? "")")
            return self
        }
    }

    @discardableResult
    func fire<ResponseModel: BaseResponseModel>(completion: @escaping HTTPCompletionClosure<ResponseModel>) -> NetworkTask? {
        self.task = self.request?.send(callbackQueue: callbackQueue, completion: completion)
        return task
    }

    func cancel() {
        task?.cancel()
    }
}

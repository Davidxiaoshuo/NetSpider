//
//  Request.swift
//  NetSpider
//
//  Created by David硕 on 2020/7/1.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import UIKit
import Apollo

class Request<Transport: NetworkTransportProtocol>: NSObject {
    
    let id = UUID().uuidString
    
    let networkTransport: Transport
    
    init(transport: Transport) {
        networkTransport = transport
    }
    
    @discardableResult
    func send<ResponseModel: BaseResponseModel>(
        callbackQueue: DispatchQueue = .main,
        completion: @escaping HTTPCompletionClosure<ResponseModel>
    ) -> NetworkTask? {
        let responseHandle = Response<ResponseModel, Transport>(
            transport: self.networkTransport,
            callbackQueue: callbackQueue,
            completionClosure: completion
        )
        return networkTransport.send { [responseHandle] (request, response, data, error) in
            if let error = error {
                responseHandle.handleError(error: error)
                return
            }
            
            if let request = request,
               let response = response,
               let data = data {
                
                responseHandle.handleResponse(
                    request: request,
                    response: response,
                    data: data
                )
                return
            }
        }
    }
    
}

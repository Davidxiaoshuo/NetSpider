//
//  GraphQLRequest.swift
//  NetSpider
//
//  Created by David硕 on 2021/2/10.
//  Copyright © 2021 David‘s Studio. All rights reserved.
//

import UIKit
import Apollo

class GraphQLRequest<Transport: NetworkTransportProtocol, Operation: GraphQLOperation>: Request<Transport> {
    
    var operation: Operation
    
    init(transport: Transport, operation: Operation) {
        self.operation = operation
        super.init(transport: transport)
    }
    
    @discardableResult
    override func send<ResponseModel>(
        callbackQueue: DispatchQueue = .main,
        completion: @escaping HTTPCompletionClosure<ResponseModel>
    ) -> NetworkTask? where Operation : GraphQLOperation, ResponseModel: BaseResponseModel {
        let responseHandle = Response<ResponseModel, Transport>(
            transport: self.networkTransport,
            callbackQueue: callbackQueue,
            completionClosure: completion
        )
        return networkTransport.send(operation: operation) { [responseHandle] (request, response, data, error) in
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

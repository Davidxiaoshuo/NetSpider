//
//  GraphQLClient.swift
//  NetSpider
//
//  Created by David硕 on 2020/11/11.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import Foundation
import Apollo

class GraphQLClient: NSObject {
    
    var transport: GraphQLNetworkTransport
    var request: Request<GraphQLNetworkTransport>?
    var task: NetworkTask?
    
    private(set) var callbackQueue: DispatchQueue = .main
    
    init(configuration: GraphQLConfiguration) {
        self.transport = GraphQLNetworkTransport(netConfiguration: configuration)
    }
    
    
    /// request
    /// - Parameters:
    ///   - isCarryToken: 是否需要携带 authorization token
    ///   - callbackQueue: callback 所处线程
    ///   - operation: GraphQLOperation
    /// - Returns: Client
    func request<Operation>(
        isCarryToken: Bool = false,
        callbackQueue: DispatchQueue = .main,
        with operation: Operation
    ) -> Self where Operation: GraphQLOperation {
        self.callbackQueue = callbackQueue
        self.transport.isCarryToken = isCarryToken
        self.request = GraphQLRequest(transport: transport, operation: operation)
        return self
    }
    
    @discardableResult
    func fire<ResponseModel>(
        completion: @escaping HTTPCompletionClosure<ResponseModel>
    ) -> NetworkTask? where ResponseModel: BaseResponseModel {
        self.task = self.request?.send(completion: completion)
        return task
    }
    
    func cancel() {
        task?.cancel()
    }
}

//
//  NetTransportProtocol.swift
//  NetSpider
//
//  Created by David硕 on 2020/11/10.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import Foundation
import Alamofire
import Apollo

public typealias ResponseHandler = (
    _ request: URLRequest?,
    _ response: HTTPURLResponse?,
    _ data: Data?,
    _ error: NetworkError?
) -> Void

public protocol NetworkTransportProtocol {
    
    associatedtype Configuration: NetConfigurationProtocol
    
    var apiType: NetSpiderDefine.HTTPAPIType { get }
    
    var netConfiguration: Configuration { get set }
    
    init(netConfiguration: Configuration)
    
    func send<Operation>(
        operation: Operation,
        completionHandler: @escaping ResponseHandler
    ) -> NetworkTask? where Operation: GraphQLOperation
    
    func send(responseHandler: @escaping ResponseHandler) -> NetworkTask?
    
}

extension NetworkTransportProtocol {

    func send<Operation>(
        operation: Operation,
        completionHandler: @escaping ResponseHandler
    ) -> NetworkTask? where Operation: GraphQLOperation {
        return nil
    }

    func send(responseHandler: @escaping ResponseHandler) -> NetworkTask? {
        return nil
    }
}

public protocol NetworkTask: class {
    
    func cancel()
    
}

extension DataRequest: NetworkTask { }

extension URLSessionTask: NetworkTask  { }

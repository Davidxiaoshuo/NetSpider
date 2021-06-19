//
//  GraphQLNetworkTransport.swift
//  NetSpider
//
//  Created by David硕 on 2020/11/9.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import Foundation
import Apollo

class GraphQLNetworkTransport: NSObject, NetworkTransportProtocol {
    
    public typealias Configuration = GraphQLConfiguration
    
    var apiType: NetSpiderDefine.HTTPAPIType = .graphQL
    var netConfiguration: Configuration
    
    private let lock = DispatchQueue.init(label: "ai.studio.net.spider.token.locker")
    
    var authorizationToken: String? {
        get {
            lock.sync {
                _authorizationToken
            }
        }
        
        set {
            lock.sync {
                _authorizationToken = newValue
            }
        }
    }
    private var _authorizationToken: String?
    
    var isCarryToken: Bool {
        get {
            lock.sync {
                _isCarryToken
            }
        }
        
        set {
            lock.sync {
                _isCarryToken = newValue
            }
        }
    }
    private var _isCarryToken: Bool = false
    
    private var sessionConfigruration: URLSessionConfiguration
    private var session: URLSession
    
    required init(netConfiguration: Configuration) {
        self.netConfiguration = netConfiguration
        self.sessionConfigruration = URLSessionConfiguration.default
        self.session = URLSession(configuration: sessionConfigruration)
    }


    func send<Operation>(
        operation: Operation,
        completionHandler: @escaping ResponseHandler
    ) -> NetworkTask? where Operation : GraphQLOperation {
        /// generate URLRequest
        let endpoint: String
        if _isCarryToken {
            endpoint = self.netConfiguration.authorityEndpoint
        } else {
            endpoint = self.netConfiguration.endpoint
        }
        let url: URL = self.netConfiguration.host.assembleURL(with: endpoint) ?? URL.init(fileURLWithPath: "")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        /// set http request headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.netConfiguration.httpHeaders.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        if _isCarryToken, let token = self._authorizationToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        /// set http request body
        let body = generateRequestBody(for: operation)
        request.httpBody = try? JSONSerialization.data(withJSONObject: body.jsonValue, options: .prettyPrinted)

        let task = self.session.dataTask(with: request) { [completionHandler, request] (data: Data?, response: URLResponse?, error: Error?) in
            let httpURLResponse = response as? HTTPURLResponse
            if let err = error {
                let apiError = APIResponsedError(httpURLResponse?.statusCode ?? -1, err.localizedDescription)
                completionHandler(request, httpURLResponse, nil, apiError)
                return
            }
            completionHandler(request, httpURLResponse, data, nil)
        }
        task.resume()
        return task
    }
    

    private func generateRequestBody<Operation: GraphQLOperation>(
        for operation: Operation,
        isNeedSendIdentifiers: Bool = false
    ) -> GraphQLMap {
        
        var body: GraphQLMap = [
            "operationName": operation.operationName,
            "variables": operation.variables,
            "query": operation.queryDocument
        ]
        
        if isNeedSendIdentifiers {
            guard let operationIdentifier = operation.operationIdentifier else {
                preconditionFailure("To send operation identifiers, Apollo types must be generated with operationIdentifiers")
            }
            body["id"] = operationIdentifier
        }
        return ["query": operation.queryDocument, "variables": operation.variables, "operationName": operation.operationName]
    }
    
}

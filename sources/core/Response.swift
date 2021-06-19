//
//  Response.swift
//  NetSpider
//
//  Created by David硕 on 2020/7/1.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

enum Result<ResponseModel: BaseResponseModel> {

    case success(ResponseModel)
    case failure(NetworkError)
    
}


struct HTTPResponseResult<ResponseModel: BaseResponseModel> {
    
    let jsonObj: JSONObject?
    let result: Result<ResponseModel>
    
    init(
        jsonObj: JSONObject?,
        result: Result<ResponseModel>
    ) {
        self.jsonObj = jsonObj
        self.result = result
    }
}

typealias JSONObject = [String: Any]
typealias HTTPCompletionClosure<ResponseModel: BaseResponseModel> = (_ result: HTTPResponseResult<ResponseModel>) -> Void

class Response<ResponseModel: BaseResponseModel, Transport: NetworkTransportProtocol>: NSObject {
    
    private let emptyDataStatusCodes: Set<Int> = [204, 205]
    private let successStatusCodes: [Int] = Array(200..<300)
    
    fileprivate let transport: Transport
    fileprivate let completionClosure: HTTPCompletionClosure<ResponseModel>
    fileprivate let callbackQueue: DispatchQueue
    
    init(
        transport: Transport,
        callbackQueue: DispatchQueue = .main,
        completionClosure: @escaping HTTPCompletionClosure<ResponseModel>
    ) {
        self.transport = transport
        self.callbackQueue = callbackQueue
        self.completionClosure = completionClosure
    }
    
    func handleResponse(request: URLRequest, response: HTTPURLResponse, data: Data) {
        parse(for: response, data: data)
    }
    
    func handleError(error: NetworkError) {
        
    }
    
}

extension Response {
    
    fileprivate func parse(for response: HTTPURLResponse, data: Data) {
        let statusCode = response.statusCode
        
        if !successStatusCodes.contains(statusCode) {
            let result = createResponseResult(with: nil, error: APIResponsedError(statusCode, "Service error."))
            invokeCompletionClosure(with: result)
            return
        }
        
        if emptyDataStatusCodes.contains(statusCode) {
            let result = createResponseResult(with: nil, error: APIResponsedError(statusCode, "No content."))
            invokeCompletionClosure(with: result)
            return
        }
        let result: HTTPResponseResult<ResponseModel>
        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let jsonObj = json as? JSONObject {
            result = createResponseResult(with: jsonObj, error: nil)
        } else {
            result = createResponseResult(with: nil, error: APIResponsedError(APIResponseErrorCode.parseJSONError.rawValue, "JSON serializatiion occure error."))
        }
        invokeCompletionClosure(with: result)
    }
    
    private func createResponseResult(with jsonObj: JSONObject?, error: NetworkError?) -> HTTPResponseResult<ResponseModel> {
        guard let json = jsonObj else {
            if let err = error {
                return HTTPResponseResult(jsonObj: nil, result: .failure(err))
            } else {
                let parseError = APIResponsedError(APIResponseErrorCode.parseJSONError.rawValue, "JSONObj is nil.")
                return HTTPResponseResult(jsonObj: nil, result: .failure(parseError))
            }
        }
        let model: ResponseModel?
        if transport.netConfiguration.isNeedParseDataField {
            model = ResponseModel.init(JSON: json["data"] as? [String: Any] ?? [: ])
        } else {
            model = ResponseModel.init(JSON: json)
        }
        guard let resultModel = model else {
            let parseError = APIResponsedError(APIResponseErrorCode.parseModelError.rawValue, "Parse to model is null.")
            return HTTPResponseResult(jsonObj: json, result: .failure(parseError))
        }
        return HTTPResponseResult(jsonObj: json, result: .success(resultModel))
    }
    
    private func invokeCompletionClosure(with responseResult: HTTPResponseResult<ResponseModel>) {
        // 这里不需要加 weak，避免提前释放。所以需注意 `completionClosure` 实现中，引用外部变量，必须加 weak
        self.callbackQueue.async {
            self.completionClosure(responseResult)
        }
    }
    
}

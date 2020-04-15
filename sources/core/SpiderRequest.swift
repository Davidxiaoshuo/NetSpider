//
//  SpiderRequest.swift
//  NetSpider
//
//  Created by 薄海硕 on 2019/7/2.
//  Copyright © 2019 David小硕. All rights reserved.
//

import UIKit

protocol RequestProtocol: class {
    
    var id: UUID { get }
    
}

protocol RestfulRequestProtocol: RequestProtocol {
    
//    func request()
}

protocol ApolloRequestProtocol: RequestProtocol {
    
}

typealias CombinedRequestProtocol = RestfulRequestProtocol & ApolloRequestProtocol

open class SpiderRequest: NSObject, CombinedRequestProtocol {
    
    let id: UUID
    
    override init() {
        self.id = UUID.init()
        super.init()
    }
    
    private func showAgreement(phoneNumber: String,completion: @escaping (Error?) -> Void) {
        
    }
    
}

//
//  RequestBuilder.swift
//  NetSpider
//
//  Created by David硕 on 2020/11/12.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import UIKit

public protocol ProviderProtocol {
    
    var httpProtocol: NetSpiderDefine.HTTPAPIType { get }
    
}

public protocol RequestBuilder {
    
    associatedtype Provider: ProviderProtocol
    
    func build() throws -> Provider
}

//
//  Network.swift
//  NetSpider
//
//  Created by David硕 on 2020/6/30.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import UIKit

private let instance: NetSpider = NetSpider()

class NetSpider: NSObject {
    
    static func shared() -> NetSpider {
        return instance
    }
    
    private(set) lazy var graphQLConfiguration = GraphQLNetworkTransport.Configuration(
        host: "http://luka-graphql.test1.k8s-qa.linglove.cn",
        endpoint: "/graphql",
        authorityEndpoint: "/graphql/mobile"
    )
    
    private(set) lazy var restfulConfiguration = RestfulNetworkTransport.Configuration(
        host: "https://api.imjad.cn",
        commonHeaders: [: ],
        isNeedParseDataField: false
    )
    
    private(set) lazy var graphQL = GraphQLClient(configuration: graphQLConfiguration)
    private(set) lazy var restful = RestfulClient(configuration: restfulConfiguration)

}

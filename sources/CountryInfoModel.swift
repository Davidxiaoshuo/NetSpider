//
//  CountryInfoModel.swift
//  NetSpider
//
//  Created by David硕 on 2020/11/11.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import UIKit
import ObjectMapper

class CoutryListModel: BaseResponseModel {
    var contryList: [CountryInfoModel] = []
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        contryList <- map["countryList"]
    }

}

class CountryInfoModel: BaseResponseModel {
    
    var region: String = ""
    var name: String = ""
    var diallingCode: String = ""
    var weight: Int = 0
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        region <- map["region"]
        name <- map["name"]
        diallingCode <- map["diallingCode"]
        weight <- map["weight"]
    }

}

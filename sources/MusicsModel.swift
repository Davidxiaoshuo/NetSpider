//
//  MusicModel.swift
//  NetSpider
//
//  Created by David硕 on 2020/7/31.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import UIKit
import ObjectMapper

class MusicsModel: BaseResponseModel{
    
    var data: [MusicModel] = []
    var code: Int?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        data <- map["data"]
        code <- map["code"]
    }

}

class MusicModel: NSObject, Mappable {
    
    var id: String?
    var url: String?
    var br: Int?
    var size: Int?
    var md5: String?
    var code: Int?
    var expi: Int?
    var type: String?
    var gain: Int?
    var fee: Int?
    var uf: String?
    var payed: Int?
    var flag: Int?
    var canExtend: Bool = false
    var freeTrialInfo: String?
    var level: String?
    var encodeType: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
        br <- map["br"]
        size <- map["size"]
        md5 <- map["md5"]
        code <- map["code"]
        expi <- map["expi"]
        type <- map["type"]
        gain <- map["gain"]
        fee <- map["fee"]
        uf <- map["uf"]
        payed <- map["payed"]
        flag <- map["flag"]
        canExtend <- map["canExtend"]
        freeTrialInfo <- map["reeTrialInfo"]
        level <- map["level"]
        encodeType <- map["encodeType"]
    }
    
}



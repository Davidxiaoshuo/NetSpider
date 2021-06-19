//
//  DictionaryExtension.swift
//  NetSpider
//
//  Created by David硕 on 2020/7/31.
//  Copyright © 2020 David‘s Studio. All rights reserved.
//

import UIKit

extension Dictionary where Key == String, Value == Any {

    mutating func append(other: [String: Any]) {
        for (key, value) in other {
            self.updateValue(value, forKey: key)
        }
    }
}

extension Dictionary where Key == String, Value == String {
    
    mutating func append(other: [String: String]) {
        for (key, value) in other {
            self.updateValue(value, forKey: key)
        }
    }
}

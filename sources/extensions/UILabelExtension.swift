//
//  UILabelExtension.swift
//  NetSpider
//
//  Created by David硕 on 2021/5/24.
//  Copyright © 2021 David硕. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// 获取自适应宽度 value
    /// 调用之前需设置：固定高度，font， text
    var sizeFitWidth: CGFloat {
        let title = self.text ?? ""
        if title.isEmpty { return self.frame.width }
        self.sizeToFit()
        return self.frame.width
    }
    
    /// 获取自适应高度 value
    /// 调用之前需设置：固定宽度，font，text
    var sizeFitHeight: CGFloat {
        let title = self.text ?? ""
        if title.isEmpty { return self.frame.height }
        self.sizeToFit()
        return self.frame.height
    }
    
}

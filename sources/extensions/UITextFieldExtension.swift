//
//  UITextFieldExtension.swift
//  NetSpider
//
//  Created by David硕 on 2021/5/24.
//  Copyright © 2021 David硕. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setLeftView<View: UIView>(view: View) {
        self.leftViewMode = .always
        self.leftView = view
    }
    
    func setRightView<View: UIView>(view: View) {
        self.rightViewMode = .always
        self.rightView = view
    }
}

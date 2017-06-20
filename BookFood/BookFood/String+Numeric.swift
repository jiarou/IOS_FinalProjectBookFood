//
//  String+Numeric.swift
//  Finalproject0612
//
//  Created by MAC on 2017/6/12.
//  Copyright © 2017年 MAC. All rights reserved.
//

import Foundation

extension String {
    func isNumericString() -> Bool {
        
        let nonDigitChars = CharacterSet.decimalDigits.inverted
        
        let string = self as NSString
        
        if string.rangeOfCharacter(from: nonDigitChars).location == NSNotFound {
            // definitely numeric entierly
            return true
        }
        
        return false
    }
}

//
//  Number + EX.swift
//  test
//
//  Created by Behnam on 12/21/21.
//  Copyright © 2021 Part DP. All rights reserved.
//

import Foundation

extension Int {
    
    var seprated:String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(integerLiteral: self))!
    }
    
}

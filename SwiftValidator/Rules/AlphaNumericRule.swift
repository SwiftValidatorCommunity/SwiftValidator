//
//  AlphaNumericRule.swift
//  Validator
//
//  Created by Bhargav Gurlanka on 2/4/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

public class AlphaNumericRule: CharacterSetRule {
    public init(message: String = "Enter valid numeric characters") {
        super.init(characterSet: NSCharacterSet.alphanumericCharacterSet(), message: message)
    }
}
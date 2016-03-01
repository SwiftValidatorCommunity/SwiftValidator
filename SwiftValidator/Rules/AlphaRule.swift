//
//  AlphaRule.swift
//  Validator
//
//  Created by Bhargav Gurlanka on 2/4/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

public class AlphaRule: CharacterSetRule {
    public init(message: String = "Enter valid alphabetic characters") {
        super.init(characterSet: NSCharacterSet.letterCharacterSet(), message: message)
    }
}
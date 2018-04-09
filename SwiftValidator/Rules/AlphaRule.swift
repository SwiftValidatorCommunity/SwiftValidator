//
//  AlphaRule.swift
//  Validator
//
//  Created by Bhargav Gurlanka on 2/4/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

/**
 `AlphaRule` is a subclass of `CharacterSetRule`. It is used to verify that a field has a
 valid list of alpha characters.
 */
open class AlphaRule: CharacterSetRule {
    
    /**
     Initializes an `AlphaRule` object to verify that a field has valid set of alpha characters.
     
     - parameter message: String of error message.
     - returns: An initialized object, or nil if an object could not be created for some reason.
     */
    public init(message: String = "Enter valid alphabetic characters") {
        super.init(characterSet: CharacterSet.letters, message: message)
    }
}

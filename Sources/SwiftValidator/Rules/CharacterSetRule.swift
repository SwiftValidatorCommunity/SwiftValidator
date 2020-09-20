//
//  CharacterSetRule.swift
//  Validator
//
//  Created by Bhargav Gurlanka on 2/4/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

/**
 `CharacterSetRule` is a subclass of `Rule`. It is used to validate IPV4 address fields.
 */
public class CharacterSetRule: Rule {
    /// NSCharacter that hold set of valid characters to hold
    private let characterSet: CharacterSet
    /// String that holds error message
    private var message: String
    
    /**
     Initializes a `CharacterSetRule` object to verify that field has valid set of characters.
     
     - parameter characterSet: NSCharacterSet that holds group of valid characters.
     - parameter message: String of error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(characterSet: CharacterSet, message: String = "Enter valid alpha") {
        self.characterSet = characterSet
        self.message = message
    }
    
    /**
     Used to validate field.
     
     - parameter value: String to checked for validation.
     - returns: Boolean value. True if validation is successful; False if validation fails.
     */
    public func validate(_ value: String) -> Bool {
        for uni in value.unicodeScalars {
            guard let uniVal = UnicodeScalar(uni.value), characterSet.contains(uniVal) else {
                return false
            }
        }
        return true
    }
    
    /**
     Displays error message when field fails validation.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}

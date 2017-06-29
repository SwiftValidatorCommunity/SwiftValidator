//
//  IntegerRule.swift
//  Validator
//
//  Created by rajatjain4061 on 29/06/17.
//  Copyright © 2017 jpotts18. All rights reserved.
//

import Foundation

/**
 `IntegerRule` is a subclass of Rule that is used to make sure a the text of a field is an integer.
 */
public class IntegerRule : Rule {
    
    /// Error message to be displayed if validation fails.
    private var message : String
    
    /**
     Initializes a `IntegerRule` object to validate that the text of a field is only Integer.
     
     - parameter message: String of error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message : String = "This must be a number without a decimal"){
        self.message = message
    }
    
    /**
     Used to validate field.
     
     - parameter value: String to checked for validation.
     - returns: Boolean value. True if validation is successful; False if validation fails.
     */
    public func validate(_ value: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[0-9]+$", options: [])
        if let regex = regex {
            let match = regex.numberOfMatches(in: value, options: [], range: NSRange(location: 0, length: value.characters.count))
            return match == 1
        }
        return false
    }
    
    /**
     Displays error message when field fails validation.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}

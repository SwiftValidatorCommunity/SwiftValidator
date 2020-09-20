//
//  FloatRule.swift
//  Validator
//
//  Created by Cameron McCord on 5/5/15.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

/**
 `FloatRule` is a subclass of Rule that defines how check if a value is a floating point value.
 */
public class FloatRule:Rule {
    /// Error message to be displayed if validation fails.
    private var message : String
    
    /**
     Initializes a `FloatRule` object to validate that the text of a field is a floating point number.
     
     - parameter message: String of error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message : String = "This must be a number with or without a decimal"){
        self.message = message
    }
    
    /**
     Used to validate field.
     
     - parameter value: String to checked for validation.
     - returns: Boolean value. True if validation is successful; False if validation fails.
     */
    public func validate(_ value: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[-+]?(\\d*[.])?\\d+$", options: [])
        if let regex = regex {
            let match = regex.numberOfMatches(in: value, options: [], range: NSRange(location: 0, length: value.count))
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

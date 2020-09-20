//
//  ExactLengthRule.swift
//  Validator
//
//  Created by Jeff Potter on 2/3/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

/**
 `ExactLengthRule` is a subclass of Rule that is used to make sure a the text of a field is an exact length.
 */
public class ExactLengthRule : Rule {
    /// parameter message: String of error message.
    private var message : String = "Must be at most 16 characters long"
    /// parameter length: Integer value string length
    private var length : Int
    
    /**
     Initializes an `ExactLengthRule` object to validate the text of a field against an exact length.
     
     - parameter length: Integer value of exact string length being specified.
     - parameter message: String of error message.
     - returns: An initialized `ExactLengthRule` object, or nil if an object could not be created for some reason. that would not result in an exception.
     */
    public init(length: Int, message : String = "Must be exactly %ld characters long"){
        self.length = length
        self.message = String(format: message, self.length)
    }
    
    /**
     Used to validate a field.
     
     - parameter value: String to checked for validation.
     - returns: A boolean value. True if validation is successful; False if validation fails.
     */
    public func validate(_ value: String) -> Bool {
        return value.count == length
    }
    
    /**
     Displays error message if a field fails validation.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}

//
//  RegexRule.swift
//  Validator
//
//  Created by Jeff Potter on 4/3/15.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
/**
 `RegexRule` is a subclass of Rule that defines how a regular expression is validated.
 */
public class RegexRule : Rule {
    /// Regular express string to be used in validation.
    private var REGEX: String = "^(?=.*?[A-Z]).{8,}$"
    /// String that holds error message.
    private var message : String
    
    /**
     - parameter regex: Regular expression string to be used in validation.
     - parameter message: String of error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(regex: String, message: String = "Invalid Regular Expression"){
        self.REGEX = regex
        self.message = message
    }
    /**
     - parameter value: String to checked for validation.
     - returns: Boolean value. True if validation is successful; False if validation fails.
     */
    public func validate(value: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", self.REGEX)
        return test.evaluateWithObject(value)
    }
    /**
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}

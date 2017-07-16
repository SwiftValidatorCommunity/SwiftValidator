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
open class RegexRule : Rule {
    /// Regular express string to be used in validation.
    private var REGEX: String = "^(?=.*?[A-Z]).{8,}$"
    /// String that holds error message.
    private var message : String
    
    /**
     Method used to initialize `RegexRule` object.
     
     - parameter regex: Regular expression string to be used in validation.
     - parameter message: String of error message.
     - returns: An initialized `RegexRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(regex: String, message: String = "Invalid Regular Expression"){
        self.REGEX = regex
        self.message = message
    }
    
    /**
     Method used to validate field.
     
     - parameter value: String to checked for validation.
     - returns: Boolean value. True if validation is successful; False if validation fails.
     */
    open func validate(_ value: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", self.REGEX)
        return test.evaluate(with: value)
    }
    
    /**
     Method used to dispaly error message when field fails validation.
     
     - returns: String of error message.
     */
    open func errorMessage() -> String {
        return message
    }
}

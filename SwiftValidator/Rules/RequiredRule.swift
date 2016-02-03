//
//  Required.swift
//  pyur-ios
//
//  Created by Jeff Potter on 12/22/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
/**
 `RequiredRule` is a subclass of Rule that defines how a required field is validated.
 */
public class RequiredRule: Rule {
    /// String that holds error message.
    private var message : String
    /**
     - parameter message: String of error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
    */
    public init(message : String = "This field is required"){
        self.message = message
    }
    /**
     - parameter value: String to checked for validation.
     - returns: Boolean value. True if validation is successful; False if validation fails.
    */
    public func validate(value: String) -> Bool {
        return !value.isEmpty
    }
    /**
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}
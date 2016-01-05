//
//  FullNameValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/19/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

/**
 `FullNameRule` is a subclass of Rule that defines how a full name is validated.
 */
public class FullNameRule : Rule {
    /// Error message to be displayed if validation fails.
    private var message : String
    /**
     - parameter message: String of error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message : String = "Please provide a first & last name"){
        self.message = message
    }
    /**
     - parameter value: String to checked for validation.
     - returns: A boolean value. True if validation is successful; False if validation fails.
     */
    public func validate(value: String) -> Bool {
        let nameArray: [String] = value.characters.split { $0 == " " }.map { String($0) }
        return nameArray.count >= 2
    }
    /**
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}
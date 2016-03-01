//
//  ConfirmRule.swift
//  Validator
//
//  Created by Jeff Potter on 3/6/15.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

/**
 `ConfirmationRule` is a subclass of Rule that defines how a text field that has to be equal
 to another text field is validated.
 */
public class ConfirmationRule: Rule {
    /// parameter confirmField: text field to which original text field will be compared to.
    private let confirmField: UITextField
    /// parameter message: String of error message.
    private var message : String
    
    /**
     Initializes a `ConfirmationRule` object to validate the text of a text field that should equal the text of another text field.
     
     - parameter confirmField: text field to which original text field will be compared to.
     - parameter message: String of error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(confirmField: UITextField, message : String = "This field does not match"){
        self.confirmField = confirmField
        self.message = message
    }
    
    /**
     Used to validate a text field.
     
     - parameter value: String to checked for validation.
     - returns: A boolean value. True if validation is successful; False if validation fails.
     */
    public func validate(value: String) -> Bool {
        return confirmField.text == value
    }
    
    /**
     Displays an error message when text field fails validation.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}
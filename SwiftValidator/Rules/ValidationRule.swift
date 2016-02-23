//
//  ValidationRule.swift
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

/**
 `ValidationRule` is a class that creates an object which holds validation info of a text field.
 */
public class ValidationRule : NSObject {
    /// the text field of the field
    public var textField:UITextField
    /// the errorLabel of the field
    public var errorLabel:UILabel?
    /// the rules of the field
    public var rules:[Rule] = []
    
    public var sanitizers: [Sanitizer]?
    
    /**
     Initializes `ValidationRule` instance with text field, rules, and errorLabel.
     
     - parameter textField: text field that holds actual text in text field.
     - parameter errorLabel: label that holds error label of text field.
     - parameter rules: array of Rule objects, which text field will be validated against.
     - returns: An initialized `ValidationRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(textField: UITextField, rules:[Rule], errorLabel:UILabel?, sanitizers: [Sanitizer]? = nil){
        self.textField = textField
        self.errorLabel = errorLabel
        self.rules = rules
        self.sanitizers = sanitizers
    }
    
    /**
     Used to validate text field against its validation rules.
     - returns: `ValidationError` object if at least one error is found. Nil is returned if there are no validation errors.
     */
    public func validateField() -> ValidationError? {
        // make any preparations if there are any
        if let sanitizers = sanitizers {
            print("called sanitizer")
            for sanitizer in sanitizers {
                sanitizer.sanitize(self.textField)
            }
        }
        
        // check against prepare rules before validation
        return rules.filter{ !$0.validate(self.textField.text ?? "") }
                    .map{ rule -> ValidationError in return ValidationError(textField: self.textField, errorLabel:self.errorLabel, error: rule.errorMessage()) }.first
    }
}
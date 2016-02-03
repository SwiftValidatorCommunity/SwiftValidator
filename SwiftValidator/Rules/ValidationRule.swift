//
//  ValidationRule.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

/**
 `ValidationRule` is a class that creates an object which holds validation info of a field.
*/
public class ValidationRule {
    /// the textField of the field
    public var textField:UITextField
    /// the errorLabel of the field
    public var errorLabel:UILabel?
    /// the rules of the field
    public var rules:[Rule] = []
    
    /**
     Initializes ValidationRule instance with textField, rules, and errorLabel.
     - parameter textField: UITextField that holds actual text in field.
     - parameter errorLabel: UILabel that holds error label of field.
     - parameter rules: array of Rule objects, which field will be validated against.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
    */
    public init(textField: UITextField, rules:[Rule], errorLabel:UILabel?){
        self.textField = textField
        self.errorLabel = errorLabel
        self.rules = rules
    }
    
    /**
     This method is used to validate field against its validation rules.
     - returns: `ValidationError` object if at least one error is found. Nil is returned if there are no validation errors.
    */
    public func validateField() -> ValidationError? {
        return rules.filter{ !$0.validate(self.textField.text ?? "") }
                    .map{ rule -> ValidationError in return ValidationError(textField: self.textField, errorLabel:self.errorLabel, error: rule.errorMessage()) }.first
    }
}
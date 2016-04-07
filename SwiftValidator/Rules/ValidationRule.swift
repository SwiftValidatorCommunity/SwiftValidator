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
public class ValidationRule {
    /// the errorLabel of the field
    public var errorLabel:UILabel?
    /// the rules of the field
    public var rules:[Rule] = []
}

public class TextFieldValidationRule: ValidationRule  {
    public var textField: UITextField?
    
    /**
     Initializes `ValidationRule` instance with text field, rules, and errorLabel.
     
     - parameter textField: text field that holds actual text in text field.
     - parameter errorLabel: label that holds error label of text field.
     - parameter rules: array of Rule objects, which text field will be validated against.
     - returns: An initialized `ValidationRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(textField: UITextField, rules:[Rule], errorLabel:UILabel?){
        super.init()
        self.textField = textField
        self.errorLabel = errorLabel
        self.rules = rules
    }
    
    /**
     Used to validate text field against its validation rules.
     - returns: `ValidationError` object if at least one error is found. Nil is returned if there are no validation errors.
     */
    public func validateField() -> ValidationError? {
        for rule in rules {
            if !rule.validate(textField!.text!) {
                return ValidationError(textField: self.textField!, error: rule.errorMessage())
            }
        }
        return nil
    }
}

public class TextViewValidationRule: ValidationRule {
    public var textView:UITextView?
    
    public init(textView: UITextView, rules:[Rule], errorLabel:UILabel?){
        super.init()
        self.textView   = textView
        self.errorLabel = errorLabel
        self.rules = rules
    }
    
    public func validateField() -> ValidationError? {
        for rule in rules {
            if !rule.validate(textView!.text) {
                return ValidationError(textView: self.textView!, error: rule.errorMessage())
            }
        }
        return nil
    }
}


public class SegmentedControlValidationRule: ValidationRule  {
    public var segmented: UISegmentedControl?
    
    public init(segmented: UISegmentedControl, rules:[Rule], errorLabel: UILabel?){
        super.init()
        self.segmented = segmented
        self.errorLabel = errorLabel
        self.rules = rules
    }
    
    public func validateField() -> ValidationError? {
        for rule in rules {
            if !rule.validate(segmented!.selectedSegmentIndex.description) {
                return ValidationError(segmentedControl: self.segmented!, error: rule.errorMessage())
            }
        }
        return nil
    }
}

public class StepperValidationRule: ValidationRule  {
    public var stepper: UIStepper?
    
    public init(stepper: UIStepper, rules:[Rule], errorLabel: UILabel?){
        super.init()
        self.stepper = stepper
        self.errorLabel = errorLabel
        self.rules = rules
    }
    
    public func validateField() -> ValidationError? {
        for rule in rules {
            if !rule.validate(stepper!.value.description) {
                return ValidationError(stepper: self.stepper!, error: rule.errorMessage())
            }
        }
        return nil
    }
}
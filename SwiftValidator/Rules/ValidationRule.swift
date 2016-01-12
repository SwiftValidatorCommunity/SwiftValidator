//
//  ValidationRule.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

public class ValidationRule {
    public var errorLabel:UILabel?
    public var rules:[Rule] = []
}

public class TextFieldValidationRule: ValidationRule  {
    public var textField: UITextField?
    
    public init(textField: UITextField, rules:[Rule], errorLabel:UILabel?){
        super.init()
        self.textField = textField
        self.errorLabel = errorLabel
        self.rules = rules
    }
    
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
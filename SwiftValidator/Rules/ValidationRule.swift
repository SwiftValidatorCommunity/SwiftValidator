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
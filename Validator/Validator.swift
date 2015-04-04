//
//  Validator.swift
//  Pingo
//
//  Created by Jeff Potter on 11/10/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol ValidationDelegate {
    func validationWasSuccessful()
    func validationFailed(errors:[UITextField:ValidationError])
}

public class Validator {
    // dictionary to handle complex view hierarchies like dynamic tableview cells
    public var errors:[UITextField:ValidationError] = [:]
    public var validations:[UITextField:ValidationRule] = [:]
    
    public init(){}
    
    // MARK: Using Keys
    
    public func registerField(textField:UITextField, rules:[Rule]) {
        validations[textField] = ValidationRule(textField: textField, rules: rules, errorLabel: nil)
    }
    
    public func registerField(textField:UITextField, errorLabel:UILabel, rules:[Rule]) {
        validations[textField] = ValidationRule(textField: textField, rules:rules, errorLabel:errorLabel)
    }
    
    public func validateAll(delegate:ValidationDelegate) {
        
        for field in validations.keys {
            if let currentRule:ValidationRule = validations[field] {
                if var error:ValidationError = currentRule.validateField() {
                    if (currentRule.errorLabel != nil) {
                        error.errorLabel = currentRule.errorLabel
                    }
                    errors[field] = error
                } else {
                    errors.removeValueForKey(field)
                }
            }
        }
        
        if errors.isEmpty {
            delegate.validationWasSuccessful()
        } else {
            delegate.validationFailed(errors)
        }
    }
    
    func clearErrors(){
        self.errors = [:]
    }
    
}
//
//  Validator.swift
//  Pingo
//
//  Created by Jeff Potter on 11/10/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol ValidationDelegate {
    func validationSuccessful()
    func validationFailed(errors: [UITextField:ValidationError])
}

public class Validator {
    // dictionary to handle complex view hierarchies like dynamic tableview cells
    public var errors:[UITextField:ValidationError] = [:]
    public var validations:[UITextField:ValidationRule] = [:]
    public var markTextFieldsInError:Bool = false
    public var textFieldErrorColor:UIColor = UIColor.redColor()
    
    public init(){}
    
    // MARK: Using Keys
    
    public func registerField(textField:UITextField, rules:[Rule]) {
        validations[textField] = ValidationRule(textField: textField, rules: rules, errorLabel: nil)
    }
    
    public func registerField(textField:UITextField, errorLabel:UILabel, rules:[Rule]) {
        validations[textField] = ValidationRule(textField: textField, rules:rules, errorLabel:errorLabel)
    }
    
    public func unregisterField(textField:UITextField) {
        validations.removeValueForKey(textField)
        errors.removeValueForKey(textField)
    }
    
    private func markTextFieldAsInError(field:UITextField) {
        field.layer.borderColor = self.textFieldErrorColor.CGColor
        field.layer.borderWidth = 1.0
    }
    
    public func validate(delegate:ValidationDelegate) {
        
        for field in validations.keys {
            if let currentRule: ValidationRule = validations[field] {
                if var error: ValidationError = currentRule.validateField() {
                    if let errorLabel = currentRule.errorLabel {
                        errorLabel.text = error.errorMessage
                    }
                    if markTextFieldsInError {
                        self.markTextFieldAsInError(field)
                    }
                    errors[field] = error
                } else {
                    errors.removeValueForKey(field)
                    if let errorLabel = currentRule.errorLabel {
                        errorLabel.text = nil
                    }
                }
            }
        }
        
        if errors.isEmpty {
            delegate.validationSuccessful()
        } else {
            delegate.validationFailed(errors)
        }
    }
    
    public func validate(callback:(errors:[UITextField:ValidationError])->Void) -> Void {
        
        for field in validations.keys {
            if let currentRule:ValidationRule = validations[field] {
                if var error:ValidationError = currentRule.validateField() {
                    if let errorLabel = currentRule.errorLabel {
                        errorLabel.text = error.errorMessage
                    }
                    if markTextFieldsInError {
                        self.markTextFieldAsInError(field)
                    }
                    errors[field] = error
                } else {
                    errors.removeValueForKey(field)
                    if let errorLabel = currentRule.errorLabel {
                        errorLabel.text = nil
                    }
                }
            }
        }
        
        callback(errors: errors)
    }
    
    func clearErrors() {
        self.errors = [:]
    }
}
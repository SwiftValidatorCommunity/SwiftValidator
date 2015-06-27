//
//  Validator.swift
//  Pingo
//
//  Created by Jeff Potter on 11/10/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

public class Validator {
    // dictionary to handle complex view hierarchies like dynamic tableview cells
    public var errors:[UITextField:ValidationError] = [:]
    public var validations:[UITextField:ValidationRule] = [:]
    private var successStyleTransform:((validationRule:ValidationRule)->Void)?
    private var errorStyleTransform:((validationError:ValidationError)->Void)?
    
    lazy public var validationWithCallback : (callback:(errors:[UITextField:ValidationError])->Void) -> () = self.validateAllFields
    
    public init(){}
    
    // MARK: Private functions
    
    private func clearErrors() {
        self.errors = [:]
    }
    
    private func validateAllFields(callback:(errors:[UITextField:ValidationError])->Void) {
        
        self.clearErrors()
        
        for field in validations.keys {
            if let currentRule: ValidationRule = validations[field] {
                if var error: ValidationError = currentRule.validateField() {
                    errors[field] = error
                    
                    // let the user transform the field if they want
                    if let transform = self.errorStyleTransform {
                        transform(validationError: error)
                    }
                } else {
                    // No error
                    // let the user transform the field if they want
                    if let transform = self.successStyleTransform {
                        transform(validationRule: currentRule)
                    }
                }
            }
        }
        
        callback(errors: errors)
    }
    
    // MARK: Using Keys
    
    public func styleTransformers(#success:((validationRule:ValidationRule)->Void)?, error:((validationError:ValidationError)->Void)?) {
        self.successStyleTransform = success
        self.errorStyleTransform = error
    }
    
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
}

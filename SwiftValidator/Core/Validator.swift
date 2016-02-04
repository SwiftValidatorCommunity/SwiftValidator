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
    public var errors = [UITextField:ValidationError]()
    public var validations = [UITextField:ValidationRule]()
    private var successStyleTransform:((validationRule:ValidationRule)->Void)?
    private var errorStyleTransform:((validationError:ValidationError)->Void)?
    
    public init(){}
    
    // MARK: Private functions
    
    private func validateAllFields() {
        
        errors = [:]
        
        for (textField, rule) in validations {
            if let error = rule.validateField() {
                errors[textField] = error
                
                // let the user transform the field if they want
                if let transform = self.errorStyleTransform {
                    transform(validationError: error)
                }
            } else {
                // No error
                // let the user transform the field if they want
                if let transform = self.successStyleTransform {
                    transform(validationRule: rule)
                }
            }
        }
    }
    
    // MARK: Public functions
    
    public func validateField(textField: UITextField, callback: (error:ValidationError?) -> Void){
        if let fieldRule = validations[textField] {
            if let error = fieldRule.validateField() {
                if let transform = self.errorStyleTransform {
                    transform(validationError: error)
                }
                callback(error: error)
            } else {
                if let transform = self.successStyleTransform {
                    transform(validationRule: fieldRule)
                }
                callback(error: nil)
            }
        } else {
            callback(error: nil)
        }
    }
    
    // MARK: Using Keys
    
    public func styleTransformers(success success:((validationRule:ValidationRule)->Void)?, error:((validationError:ValidationError)->Void)?) {
        self.successStyleTransform = success
        self.errorStyleTransform = error
    }
    
    public func registerField(textField:UITextField, rules:[Rule]) {
        registerFieldInternally(textField, errorLabel: nil, preparators: nil, rules: rules)
    }
    
    public func registerField(textField:UITextField, errorLabel:UILabel, rules:[Rule]) {
        registerFieldInternally(textField, errorLabel: errorLabel, preparators: nil, rules: rules)
    }
    
    public func registerField(textField:UITextField, preparators: [Preparator], rules:[Rule]) {
        registerFieldInternally(textField, errorLabel: nil, preparators: preparators, rules: rules)
    }
    
    public func registerField(textField:UITextField, errorLabel:UILabel, preparators: [Preparator], rules:[Rule]) {
        registerFieldInternally(textField, errorLabel: errorLabel, preparators: preparators, rules: rules)
    }
    
    private func registerFieldInternally(textField: UITextField, errorLabel: UILabel?, preparators: [Preparator]?, rules: [Rule]) {
        validations[textField] = ValidationRule(textField: textField, preparators: preparators, rules: rules, errorLabel: errorLabel)
    }
    
    public func unregisterField(textField:UITextField) {
        validations.removeValueForKey(textField)
        errors.removeValueForKey(textField)
    }
    
    public func validate(delegate:ValidationDelegate) {
        
        self.validateAllFields()
        
        if errors.isEmpty {
            delegate.validationSuccessful()
        } else {
            delegate.validationFailed(errors)
        }
    }
    
    public func validate(callback:(errors:[UITextField:ValidationError])->Void) -> Void {
        
        self.validateAllFields()
        
        callback(errors: errors)
    }
}

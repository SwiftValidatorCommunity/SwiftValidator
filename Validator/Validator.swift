//
//  Validator.swift
//  Pingo
//
//  Created by Jeff Potter on 11/10/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

public typealias ValidatorErrors = [(field: UITextField, error: ValidationError)]
public typealias ValidatorRules = [(field: UITextField, rule: ValidationRule)]

public protocol ValidationDelegate {
    func validationSuccessful()
    func validationFailed(errors: ValidatorErrors)
}

public class Validator {
    // dictionary to handle complex view hierarchies like dynamic tableview cells
    public var errors: ValidatorErrors = []
    public var validations: ValidatorRules = []
    private var successStyleTransform:((validationRule:ValidationRule)->Void)?
    private var errorStyleTransform:((validationError:ValidationError)->Void)?
    
    public init(){}
    
    // MARK: Private functions
    
    private func validateAllFields() {
        errors.removeAll()
        
        for (textField, rule) in validations {
            if let error: ValidationError = rule.validateField() {
                errors.append(field: textField, error: error)
                
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
    
    // MARK: Using Keys
    
    public func styleTransformers(#success:((validationRule:ValidationRule)->Void)?, error:((validationError:ValidationError)->Void)?) {
        self.successStyleTransform = success
        self.errorStyleTransform = error
    }
    
    public func registerField(textField:UITextField, rules:[Rule]) {
        validations.append(field: textField, rule: ValidationRule(textField: textField, rules: rules, errorLabel: nil))
    }
    
    public func registerField(textField:UITextField, errorLabel:UILabel, rules:[Rule]) {
        validations.append(field: textField, rule:ValidationRule(textField: textField, rules:rules, errorLabel:errorLabel))
    }
    
    public func unregisterField(textField:UITextField) {
        if let validationIndex = validations.find({ $0.0 == textField}) {
            validations.removeAtIndex(validationIndex)
        }
        
        if let errorIndex = errors.find({ $0.0 == textField}) {
            validations.removeAtIndex(errorIndex)
        }
    }
    
    public func validate(delegate:ValidationDelegate) {
        self.validateAllFields()
        
        if errors.isEmpty {
            delegate.validationSuccessful()
        } else {
            delegate.validationFailed(errors)
        }
    }
    
    public func validate(callback:(errors:ValidatorErrors)->Void) -> Void {
        self.validateAllFields()
        
        callback(errors: errors)
    }
}

private extension Array {
    func find(includedElement: T -> Bool) -> Int? {
        for (idx, element) in enumerate(self) {
            if includedElement(element) {
                return idx
            }
        }
        return nil
    }
}

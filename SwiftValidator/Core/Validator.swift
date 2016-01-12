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
    func validationFailed(errors: [UITextField:ValidationError], segmentedControlErrors: [UISegmentedControl:ValidationError])
}

public class Validator {
    // dictionary to handle complex view hierarchies like dynamic tableview cells
    private var successStyleTransform:((validationRule:ValidationRule)->Void)?
    private var errorStyleTransform:((validationError:ValidationError)->Void)?
    
    public var textFieldErrors:[UITextField:ValidationError] = [:]
    public var segmentedControlErrors:[UISegmentedControl:ValidationError] = [:]
    
    public var textFieldValidations:[UITextField:ValidationRule] = [:]
    public var segmentedControlValidations:[UISegmentedControl:ValidationRule] = [:]
    
    public init(){}
    
    // MARK: Private functions
    
    private func validateAllFields() {
        
        textFieldErrors = [:]
        segmentedControlErrors = [:]
        
//        for (textField, rule) in validations {
//            if let error = rule.validateField() {
//                errors[textField] = error
//                
//                // let the user transform the field if they want
//                if let transform = self.errorStyleTransform {
//                    transform(validationError: error)
//                }
//            } else {
//                // No error
//                // let the user transform the field if they want
//                if let transform = self.successStyleTransform {
//                    transform(validationRule: rule)
//                }
//            }
//        }
        
        for field in textFieldValidations.keys {
            if let currentRule: TextFieldValidationRule = textFieldValidations[field] as? TextFieldValidationRule {
                if let error: ValidationError = currentRule.validateField() {
                    if currentRule.errorLabel != nil {
                        error.errorLabel = currentRule.errorLabel
                    }
                    textFieldErrors[field] = error
                    
                    // let the user transform the field if they want
                    if let transform = self.errorStyleTransform {
                        transform(validationError: error)
                    }
                } else {
                    textFieldErrors.removeValueForKey(field)
                }
            }
        }
    }
    
    // MARK: Using Keys
    
    public func styleTransformers(success success:((validationRule:ValidationRule)->Void)?, error:((validationError:ValidationError)->Void)?) {
        self.successStyleTransform = success
        self.errorStyleTransform = error
    }
    
    public func registerField(textField:UITextField, rules:[Rule]) {
        textFieldValidations[textField] = TextFieldValidationRule(textField: textField, rules: rules, errorLabel: nil)
    }
    
    public func registerField(textField:UITextField, errorLabel:UILabel, rules:[Rule]) {
        textFieldValidations[textField] = TextFieldValidationRule(textField: textField, rules:rules, errorLabel:errorLabel)
    }
    
    public func registerField(segmented:UISegmentedControl, errorLabel:UILabel, rules:[Rule]) {
        segmentedControlValidations[segmented] = SegmentedControlValidationRule(segmented: segmented, rules:rules, errorLabel:errorLabel)
    }
    
    public func unregisterField(textField:UITextField) {
        textFieldValidations.removeValueForKey(textField)
        textFieldErrors.removeValueForKey(textField)
    }
    
    public func unregisterField(segmented:UISegmentedControl) {
        segmentedControlValidations.removeValueForKey(segmented)
        segmentedControlErrors.removeValueForKey(segmented)
    }
    
    public func validate(delegate:ValidationDelegate) {
        
        self.validateAllFields()
        
        if textFieldErrors.isEmpty && segmentedControlErrors.isEmpty {
            delegate.validationSuccessful()
        } else {
            delegate.validationFailed(textFieldErrors, segmentedControlErrors: segmentedControlErrors)
        }
    }
    
    public func validate(callback:(textFieldErrors:[UITextField:ValidationError], segmentedControlErrors:[UISegmentedControl:ValidationError])->Void) -> Void {
        
        self.validateAllFields()
        
        callback(textFieldErrors: textFieldErrors, segmentedControlErrors: segmentedControlErrors)
    }
}

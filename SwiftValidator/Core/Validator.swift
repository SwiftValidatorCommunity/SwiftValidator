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
    func validationFailed(textFieldErrors: [UITextField:ValidationError], textViewErrors:[UITextView:ValidationError], segmentedControlErrors: [UISegmentedControl:ValidationError], stepperErrors:[UIStepper:ValidationError])
}

public class Validator {
    // dictionary to handle complex view hierarchies like dynamic tableview cells
    private var successStyleTransform:((validationRule:ValidationRule)->Void)?
    private var errorStyleTransform:((validationError:ValidationError)->Void)?
    
    public var textFieldErrors:[UITextField:ValidationError] = [:]
    public var textViewErrors:[UITextView:ValidationError] = [:]
    public var segmentedControlErrors:[UISegmentedControl:ValidationError] = [:]
    public var stepperErrors:[UIStepper:ValidationError] = [:]
    
    public var textFieldValidations:[UITextField:ValidationRule] = [:]
  	public var textViewValidations:[UITextView:ValidationRule] = [:]
    public var segmentedControlValidations:[UISegmentedControl:ValidationRule] = [:]
  	public var stepperValidations:[UIStepper:ValidationRule] = [:]
    
    public init(){}
    
    // MARK: Private functions
    
    private func validateAllFields() {
        
        textFieldErrors = [:]
        segmentedControlErrors = [:]
        textViewErrors = [:]
        stepperErrors = [:]
                
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
                    
                    // let the user transform the field if they want
                    if let transform = self.successStyleTransform {
                        transform(validationRule: currentRule)
                    }
                }
            }
        }
        
        for field in textViewValidations.keys {
            if let currentRule: TextViewValidationRule = textViewValidations[field] as? TextViewValidationRule {
                if let error: ValidationError = currentRule.validateField() {
                    if currentRule.errorLabel != nil {
                        error.errorLabel = currentRule.errorLabel
                    }
                    textViewErrors[field] = error
                    
                    // let the user transform the field if they want
                    if let transform = self.errorStyleTransform {
                        transform(validationError: error)
                    }
                } else {
                    textViewErrors.removeValueForKey(field)
                    
                    // let the user transform the field if they want
                    if let transform = self.successStyleTransform {
                        transform(validationRule: currentRule)
                    }
                }
            }
        }
        
        for field in segmentedControlValidations.keys {
            if let currentRule: SegmentedControlValidationRule = segmentedControlValidations[field] as? SegmentedControlValidationRule {
                if let error: ValidationError = currentRule.validateField() {
                    if currentRule.errorLabel != nil {
                        error.errorLabel = currentRule.errorLabel
                    }
                    segmentedControlErrors[field] = error
                    
                    // let the user transform the field if they want
                    if let transform = self.errorStyleTransform {
                        transform(validationError: error)
                    }
                } else {
                    segmentedControlErrors.removeValueForKey(field)
                    
                    // let the user transform the field if they want
                    if let transform = self.successStyleTransform {
                        transform(validationRule: currentRule)
                    }
                }
            }
        }
        
        for field in stepperValidations.keys {
            if let currentRule: StepperValidationRule = stepperValidations[field] as? StepperValidationRule {
                if let error: ValidationError = currentRule.validateField() {
                    if currentRule.errorLabel != nil {
                        error.errorLabel = currentRule.errorLabel
                    }
                    stepperErrors[field] = error
                    
                    // let the user transform the field if they want
                    if let transform = self.errorStyleTransform {
                        transform(validationError: error)
                    }
                } else {
                    stepperErrors.removeValueForKey(field)
                    
                    // let the user transform the field if they want
                    if let transform = self.successStyleTransform {
                        transform(validationRule: currentRule)
                    }
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
    
    public func registerField(textView:UITextView, errorLabel:UILabel, rules:[Rule]) {
        textViewValidations[textView] = TextViewValidationRule(textView: textView, rules:rules, errorLabel:errorLabel)
    }
    
    public func registerField(segmented:UISegmentedControl, errorLabel:UILabel, rules:[Rule]) {
        segmentedControlValidations[segmented] = SegmentedControlValidationRule(segmented: segmented, rules:rules, errorLabel:errorLabel)
    }
    
    public func registerField(stepper:UIStepper, errorLabel:UILabel, rules:[Rule]) {
        stepperValidations[stepper] = StepperValidationRule(stepper: stepper, rules:rules, errorLabel:errorLabel)
    }
    
    public func unregisterField(textField:UITextField) {
        textFieldValidations.removeValueForKey(textField)
        textFieldErrors.removeValueForKey(textField)
    }
    
    public func unregisterField(textView:UITextView) {
        textViewValidations.removeValueForKey(textView)
        textViewErrors.removeValueForKey(textView)
    }
    
    public func unregisterField(segmented:UISegmentedControl) {
        segmentedControlValidations.removeValueForKey(segmented)
        segmentedControlErrors.removeValueForKey(segmented)
    }
    
    public func unregisterField(stepper:UIStepper) {
        stepperValidations.removeValueForKey(stepper)
        stepperErrors.removeValueForKey(stepper)
    }
    
    public func validate(delegate:ValidationDelegate) {
        
        self.validateAllFields()
        
        if textFieldErrors.isEmpty && textViewErrors.isEmpty && segmentedControlErrors.isEmpty && stepperErrors.isEmpty {
            delegate.validationSuccessful()
        } else {
            delegate.validationFailed(textFieldErrors, textViewErrors: textViewErrors, segmentedControlErrors: segmentedControlErrors, stepperErrors: stepperErrors)
        }
    }
    
    public func validate(callback:(textFieldErrors:[UITextField:ValidationError], textViewErrors: [UITextView:ValidationError], segmentedControlErrors:[UISegmentedControl:ValidationError], stepperErrors:[UIStepper:ValidationError])->Void) -> Void {
        
        self.validateAllFields()
        
        callback(textFieldErrors: textFieldErrors, textViewErrors: textViewErrors, segmentedControlErrors: segmentedControlErrors, stepperErrors: stepperErrors)
    }
}

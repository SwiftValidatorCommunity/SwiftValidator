//
//  Validator.swift
//
//  Created by Jeff Potter on 11/10/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

//@objc public protocol ValidationDelegate {
//	func validationSuccessful()
//	func validationFailed(textFieldErrors: [UITextField:ValidationError], textViewErrors:[UITextView:ValidationError], segmentedControlErrors: [UISegmentedControl:ValidationError], stepperErrors:[UIStepper:ValidationError])
//}

/**
 Class that makes `Validator` objects. Should be added as a parameter to ViewController that will display
 validation fields.
 */
public class Validator {
    /// Dictionary to hold all fields (and accompanying rules) that will undergo validation.
    public var validations = [UITextField:ValidationRule]()
    /// Dictionary to hold fields (and accompanying errors) that were unsuccessfully validated.
    public var errors = [UITextField:ValidationError]()
     /// Variable that holds success closure to display positive status of field.
    private var successStyleTransform:((validationRule:ValidationRule)->Void)?
    /// Variable that holds error closure to display negative status of field.
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
    
    /**
    This method is used to validate all fields registered to Validator. If validation is unsuccessful,
    field gets added to errors dictionary.
    - returns: No return value.
    */
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
    
    /**
    This method is used to style fields that have undergone validation checks. Success callback should be used to show common success styling and error callback should be used to show common error styling.
    
    - parameter success: A closure which is called with validationRule, an object that holds validation data
    - parameter error: A closure which is called with validationError, an object that holds validation error data
    - returns: No return value
    */
    public func styleTransformers(success success:((validationRule:ValidationRule)->Void)?, error:((validationError:ValidationError)->Void)?) {
        self.successStyleTransform = success
        self.errorStyleTransform = error
    }
    
    /**
     This method is used to add a field to validator.
     
     - parameter textField: field that is to be validated.
     - parameter Rule: An array which holds different rules to validate against textField.
     - returns: No return value
     */
    public func registerField(textField:UITextField, rules:[Rule]) {
        textFieldValidations[textField] = TextFieldValidationRule(textField: textField, rules: rules, errorLabel: nil)
    }
    
    /**
     This method is used to add a field to validator.
     
     - parameter textfield: field that is to be validated.
     - parameter errorLabel: A UILabel that holds error label data
     - parameter rules: A Rule array that holds different rules that apply to said textField.
     - returns: No return value
     */
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
    
    /**
     This method is for removing a field validator.
     
     - parameter textField: field used to locate and remove textField from validator.
     - returns: No return value
     */
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
    
    /**
     This method checks to see if all fields in validator are valid.
     
     - returns: No return value.
     */
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

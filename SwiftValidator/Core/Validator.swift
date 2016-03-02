//
//  Validator.swift
//
//  Created by Jeff Potter on 11/10/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

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
    public var delegate: ValidationDelegate?
    private var successStyleTransform:((validationRule:ValidationRule)->Void)?
    /// Variable that holds error closure to display negative status of field.
    private var errorStyleTransform:((validationError:ValidationError)->Void)?
    /// - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
    private var completedValidationsCount: Int = 0
    public init(){}
    
    // MARK: Private functions
    
    /**
    This method is used to validate all fields registered to Validator. If validation is unsuccessful,
    field gets added to errors dictionary.
    - returns: No return value.
    */
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
    
    /**
     This method is used to validate all fields registered to Validator. If validation is unsuccessful,
     field gets added to errors dictionary. Completion closure is used to validator know when all fields
     have undergone validation attempt.
     - parameter completion: Bool that is set to true when all fields have experienced validation attempt.
     - returns: No return value.
    */
    private func validateAllFields(completion: (finished: Bool) -> Void) {
        errors = [:]
        
        for (textField, rule) in validations {
            if rule.remoteInfo != nil {
                validateRemoteField(textField, completion: { status -> Void in
                    self.completedValidationsCount = self.completedValidationsCount + 1
                    if self.completedValidationsCount == self.validations.count {
                        // Sends validation back to validate()
                        completion(finished: true)
                    }
                })
            } else {
                validateRegularField(textField)
                self.completedValidationsCount = self.completedValidationsCount + 1
                if completedValidationsCount == validations.count {
                    // Sends validation back to validate()
                    completion(finished: true)
                }
            }
        }
    }
    
    /**
     This method is used to validate a field that will need to also be validated via remote request.
     - parameter textField: TextField of field that is being validated.
     - parameter completion: Closure that holds the status of textField's validation. Is set to true
     after remote validation has ended, regardless of whether the validation was a success or failure.
     - returns: No return value.
    */
    private func validateRemoteField(textField: UITextField, completion: (status: Bool) -> Void) {
        if let fieldRule = validations[textField] {
            // Carry on with validation as regular validation passed
            if self.validateRegularField(fieldRule.textField) {
                delegate!.remoteValidationRequest!(textField.text!, urlString: fieldRule.remoteInfo!.urlString, completion: { result -> Void in
                    if result {
                        if let transform = self.successStyleTransform {
                            transform(validationRule: fieldRule)
                        }
                    } else {
                        // Stop validation because remote validation failed
                        // Validation Failed on remote call
                        let error = ValidationError(textField: fieldRule.textField, errorLabel: fieldRule.errorLabel, error: fieldRule.remoteInfo!.error)
                        self.errors[fieldRule.textField] = error
                        if let transform = self.errorStyleTransform {
                            transform(validationError: error)
                        }
                    }
                    // Validation is over, so let validateAllFields(completion: (status: Bool)) know
                    completion(status: true)
                })
            } else {
                // Validation is over, so let validateAllFields(completion: (status: Bool)) know
                completion(status: true)
            }
            
        }
    }
    
    /**
     Method used to validate a regular field (non-remote).
     - parameter: TextField of field that is undergoing validation
     - returns: A Bool that represents whether the validation was a success or failure, returns true for the
      former and false for the latter.
    */
    private func validateRegularField(textField: UITextField) -> Bool {
        if let fieldRule = validations[textField] {
            if let error = fieldRule.validateField() {
                errors[textField] = error
                if let transform = self.errorStyleTransform {
                    transform(validationError: error)
                    return false
                }
            } else {
                if let transform = self.successStyleTransform {
                    if fieldRule.remoteInfo == nil {
                        transform(validationRule: fieldRule)
                    }
                    return true
                }
            }
        }
        return false
    }
    
    // MARK: Public functions
    
    /**
    This method is used to validate a single field registered to Validator. If validation is unsuccessful,
    field gets added to errors dictionary.
    - parameter textField: Holds validator field data.
    - returns: No return value.
    */
    public func validateField(textField: UITextField, callback: (error:ValidationError?) -> Void){
        if let fieldRule = validations[textField] {
            if let error = fieldRule.validateField() {
                errors[textField] = error
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
    public func registerField(textField:UITextField, rules:[Rule], remoteInfo: (String, String)? = nil) {
        validations[textField] = ValidationRule(textField: textField, rules: rules, errorLabel: nil, remoteInfo: remoteInfo)
    }
    
    /**
     This method is used to add a field to validator.
     
     - parameter textfield: field that is to be validated.
     - parameter errorLabel: A UILabel that holds error label data
     - parameter rules: A Rule array that holds different rules that apply to said textField.
     - returns: No return value
    */
    public func registerField(textField:UITextField, errorLabel:UILabel, rules:[Rule], remoteInfo: (String, String)? = nil) {
        validations[textField] = ValidationRule(textField: textField, rules:rules, errorLabel:errorLabel, remoteInfo: remoteInfo)
    }
    
    /**
     This method is for removing a field validator.
     
     - parameter textField: field used to locate and remove textField from validator.
     - returns: No return value
    */
    public func unregisterField(textField:UITextField) {
        validations.removeValueForKey(textField)
        errors.removeValueForKey(textField)
    }
    
    /**
     This method checks to see if all fields in validator are valid.
     
     - returns: No return value.
    */
    public func validate(delegate:ValidationDelegate) {
        
        self.validateAllFields()
        
        if errors.isEmpty {
            delegate.validationSuccessful()
        } else {
            delegate.validationFailed(errors)
        }
        
    }
    
    /**
     This method attempts to validate all fields registered to Validator().
      - returns: No return value.
    */
    public func validate() {
        self.validateAllFields { finished -> Void in
            if self.errors.isEmpty {
                // call success method if it's implemented
                self.delegate!.validationSuccessful()
            } else {
                // call failure method if it's implemented
                self.delegate!.validationFailed(self.errors)
            }
            // set number of completed validations back to 0
            self.completedValidationsCount = 0
        }
    }
    
    /**
     This method validates all fields in validator and sets any errors to errors parameter of closure.
     
     - parameter callback: A closure which is called with errors, a dictionary of type UITextField:ValidationError.
     
     - returns: No return value.
    */
    public func validate(callback:(errors:[UITextField:ValidationError])->Void) -> Void {
        
        self.validateAllFields()
        
        callback(errors: errors)
    }
}

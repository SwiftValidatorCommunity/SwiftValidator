//
//  Validator.swift
//  Pingo
//
//  Created by Jeff Potter on 11/10/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation
import UIKit

protocol ValidationDelegate {
    func validationWasSuccessful()
    func validationFailed(errors:[String:ValidationError])
}

protocol ValidationFieldDelegate {
    func validationFieldFailed(key:String, error:ValidationError)
    func validationFieldSuccess(key:String, validField:UITextField)
}

class Validator {
    // dictionary to handle complex view hierarchies like dynamic tableview cells
    var validationRules:[String:ValidationRule] = [:]
    var validationErrors:[String:ValidationError] = [:]
        
    init(){}
    
    // MARK: Using Keys
    
    func registerFieldByKey(key:String, textField:UITextField, rules:[ValidationRuleType]) {
        validationRules[key] = ValidationRule(textField: textField, rules: rules)
    }
    
    func validateFieldByKey(key:String, delegate:ValidationFieldDelegate) {
        if let currentRule:ValidationRule = validationRules[key] {
            if var error:ValidationError = currentRule.validateField() {
                delegate.validationFieldFailed(key, error:error)
            } else {
                delegate.validationFieldSuccess(key, validField:currentRule.textField)
            }
        }
    }
    
    func validateAllKeys(delegate:ValidationDelegate){
        
        for key in validationRules.keys {
            if let currentRule:ValidationRule = validationRules[key] {
                if var error:ValidationError = currentRule.validateField() {
                    validationErrors[key] = error
                } else {
                    validationErrors.removeValueForKey(key)
                }
            }
        }
        
        if validationErrors.isEmpty {
            delegate.validationWasSuccessful()
        } else {
            delegate.validationFailed(validationErrors)
        }
        
    }
    
}
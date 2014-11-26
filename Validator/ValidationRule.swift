//
//  ValidationRule.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation
import UIKit

class ValidationRule {
    let textField:UITextField
    var rules:[ValidationRuleType] = []
    
    init(textField:UITextField, rules:[ValidationRuleType]){
        self.textField = textField
        self.rules = rules
    }
    
    func validateField() -> ValidationError? {
        for rule in rules {
            var validation = ValidationFactory.validationForRule(rule)
            var attempt:(isValid:Bool, error:ValidationErrorType) = validation.validate(textField.text)
            if !attempt.isValid {
                return ValidationError(textField: textField, error: attempt.error)
            }
        }
        return nil
    }
    
}
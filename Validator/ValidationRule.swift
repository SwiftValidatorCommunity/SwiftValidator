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
    var textField:UITextField
    var errorLabel:UILabel?
    var rules:[Rule] = []
    
    init(textField: UITextField, rules:[Rule], errorLabel:UILabel?){
        self.textField = textField
        self.errorLabel = errorLabel
        self.rules = rules
    }
    
    func validateField() -> ValidationError? {
        for rule in rules {
            var isValid:Bool = rule.validate(textField.text)
            if !isValid {
                return ValidationError(textField: self.textField, error: rule.errorMessage())
            }
        }
        return nil
    }
    
}
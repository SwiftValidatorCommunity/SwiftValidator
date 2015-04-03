//
//  ValidationRule.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

class ValidationRule {
    var textField: UITextField
    var errorLabel: UILabel?
    var rules: [Rule] = []
    
    init(textField: UITextField, rules: [Rule], errorLabel: UILabel?){
        self.textField = textField
        self.errorLabel = errorLabel
        self.rules = rules
    }
    
    func validateField() -> ValidationError? {
        for rule in rules {
            if !rule.validate(textField.text) {
                return ValidationError(textField: self.textField, error: rule.errorMessage())
            }
        }
        return nil
    }
}
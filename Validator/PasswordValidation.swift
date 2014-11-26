//
//  PasswordValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/13/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation

class PasswordValidation : Validation {

    // Alternative Regexes

    // 8 characters. One uppercase. One Lowercase. One number.
    // var PASSWORD_REGEX = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).{8,}$"
    //
    // no length. One uppercase. One lowercae. One number.
    // var PASSWORD_REGEX = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).*?$"
    
    // 8 characters. one uppercase
    var PASSWORD_REGEX = "^(?=.*?[A-Z]).{8,}$"
    
    func validate(value: String) -> (Bool, ValidationErrorType) {
        if let passwordTes = NSPredicate(format: "SELF MATCHES %@", PASSWORD_REGEX) {
            if passwordTes.evaluateWithObject(value) {
                return (true, .NoError)
            }
            return (false, .Password)
        }
        return (false, .Password)
    }
}
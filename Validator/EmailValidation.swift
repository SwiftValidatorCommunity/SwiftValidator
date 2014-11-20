//
//  EmailValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation

class EmailValidation: Validation {
    
    let EMAIL_REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    
    func validate(value:String) -> (Bool, ValidationErrorType) {
        
        if let emailTest = NSPredicate(format: "SELF MATCHES %@", EMAIL_REGEX) {
            if emailTest.evaluateWithObject(value) {
                return (true, .NoError)
            } else {
                return (false,.Email)
            }
        }
        return (false, .Email)
    }
}
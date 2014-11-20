//
//  ZipCodeValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation

class ZipCodeValidation: Validation {
    let ZIP_REGEX = "\\d{5}"
    
    func validate(value: String) -> (Bool, ValidationErrorType) {
        if let zipTest = NSPredicate(format: "SELF MATCHES %@", ZIP_REGEX) {
            if zipTest.evaluateWithObject(value) {
                return (true, .NoError)
            }
            return (false, .ZipCode)
        }
        return (false, .ZipCode)
    }
    
}
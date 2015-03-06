//
//  PhoneValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation

class PhoneNumberRule: Rule {
//    let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
    let PHONE_REGEX = "^\\d{10}$"
    
    var message:String {
        return "Enter a valid 10 digit phone number"
    }
    
    func validate(value: String) -> Bool {
        if let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX) {
            if phoneTest.evaluateWithObject(value) {
                return true
            }
            return false
        }
        return false
    }
    
    func errorMessage() -> String {
        return message
    }
    
}

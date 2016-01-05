//
//  PhoneValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation
/**
 `PhoneNumberRule` is a subclass of Rule that defines how a phone number is validated.
 */
class PhoneNumberRule: Rule {
//    let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
    /// Regular express string to be used in validation.
    let PHONE_REGEX = "^\\d{10}$"
    /// String that holds error message.
    var message:String {
        return "Enter a valid 10 digit phone number"
    }
    /**
     - parameter value: String to checked for validation.
     - returns: Boolean value. True if validation is successful; False if validation fails.
     */
    func validate(value: String) -> Bool {
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        return phoneTest.evaluateWithObject(value)
    }
    /**
     - returns: String of error message.
     */
    func errorMessage() -> String {
        return message
    }
    
}

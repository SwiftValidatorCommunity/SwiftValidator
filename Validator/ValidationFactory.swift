//
//  Validations.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation

class ValidationFactory {
    class func validationForRule(rule:ValidationRuleType) -> Validation {
        switch rule {
        case .Required:
            return RequiredValidation()
        case .Email:
            return EmailValidation()
        case .MinLength:
            return MinLengthValidation()
        case .MaxLength:
            return MaxLengthValidation()
        case .PhoneNumber:
            return PhoneNumberValidation()
        case .ZipCode:
            return ZipCodeValidation()
        case .FullName:
            return FullNameValidation()
        default:
            return RequiredValidation()
        }
    }
}

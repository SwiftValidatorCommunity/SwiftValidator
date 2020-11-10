//
//  CanadianPostalCode function .swift
//  SwiftValidator
//
//  Created by Abdalla Elnajjar on 2020-11-08.
//  Copyright © 2020 jpotts18. All rights reserved.
//


import Foundation

/**
 `PhoneNumberRule` is a subclass of Rule that defines how a phone number is validated.
 */
public class CanadianPostalCodeRule: RegexRule {

    
    /// Canadian Postal Code express string to be used in validation.
    static let regex = "^[A-Za-z]\\d[A-Za-z][ -]?\\d[A-Za-z]\\d$"
    
    /**
     Initializes a `PhoneNumberRule` object. Used to validate that a field has a valid phone number.
     
    - parameter message: Error message that is displayed if validation fails.
    - returns: An initialized `CanadianPostalCode` object, or nil if an object could not be created for some reason that would not result in an exception.
    */
    public convenience init(message : String = "Enter a valid c digit Canadian Postal Code") {
        self.init(regex: CanadianPostalCodeRule.regex, message : message)
    }
    
}

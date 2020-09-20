//
//  CardExpiryMonthRule.swift
//  Validator
//
//  Created by Ifeanyi Ndu on 15/01/2017.
//  Copyright © 2017 jpotts18. All rights reserved.
//

import Foundation

/**
 `CardExpiryMonthRule` is a subclass of `Rule` that defines how a credit/debit's card expiry month field is validated
 */
public class CardExpiryMonthRule: Rule {
    /// Error message to be displayed if validation fails.
    private var message: String = "Must be a valid calendar month"
    /**
     Initializes `CardExpiryMonthRule` object with error message. Used to validate a card's expiry month.
     
     - parameter message: String of error message.
     - returns: An initialized `CardExpiryMonthRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message : String = "Must be a valid calendar month"){
        self.message = message
    }
    
    /**
     Validates a field.
     
     - parameter value: String to check for validation.
     - returns: Boolean value. True on successful validation, otherwise False on failed Validation.
     */
    public func validate(_ value: String) -> Bool {
        
        guard let month = Int(value) else {
            return false
        }
        return month >= 1 && month <= 12
    }
    
    /**
     Used to display error message when validation fails.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
    
}

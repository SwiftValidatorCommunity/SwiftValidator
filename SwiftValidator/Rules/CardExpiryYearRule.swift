//
//  CardExpiryYearRule.swift
//  Validator
//
//  Created by Ifeanyi Ndu on 15/01/2017.
//  Copyright © 2017 jpotts18. All rights reserved.
//

import Foundation

/**
 `CardExpiryYearRule` is a subclass of `Rule` that defines how a credit/debit's card expiry year field is validated
 */
public class CardExpiryYearRule: Rule {
    /// Error message to be displayed if validation fails.
    private var message: String = "Must be within 3 years of validity"
    ///Default maximum validity period. Change to preferred value
    private var MAX_VALIDITY: Int = 3

    /**
     Initializes `CardExpiryYearRule` object with error message. Used to validate a card's expiry year.
     
     - parameter message: String of error message.
     - returns: An initialized `CardExpiryYearRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message : String = "Must be within 3 years of validity"){

        self.message = message

    }

    /**
     Validates a field.
     
     - parameter value: String to check for validation.
     - returns: Boolean value. True on successful validation, otherwise False on failed Validation.
     */
    public func validate(_ value: String) -> Bool {

        ///Holds the current year
        let thisYear = NSCalendar.current.component(Calendar.Component.year, from: Date())

        guard let year = Int(value) else {
            return false
        }

        return year >= thisYear && year <= (thisYear + MAX_VALIDITY)
    }

    /**
     Used to display error message when validation fails.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }

}

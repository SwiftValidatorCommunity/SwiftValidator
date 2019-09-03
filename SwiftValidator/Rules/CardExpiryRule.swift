//
//  CardExpiryRule.swift
//  SwiftValidator
//
//  Created by Mark Boleigha on 13/03/2019.
//  Copyright © 2019 jpotts18. All rights reserved.
//

import Foundation



/**
 `CardExpiryRule` is a subclass of `Rule` that defines how a credit/debit's card number field is validated
 */
public class CardExpiryRule: Rule {
    /// Error message to be displayed if validation fails.
    private var message : String
    /**
     Initializes `CardExpiryRule` object with error message. Used to validate a card's expiry year.
     
     - parameter message: String of error message.
     - returns: An initialized `CardExpiryRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message : String = "Card expiry date is invalid"){
        self.message = message
    }
    
    /**
     Validates a field.
     
     - parameter value: String to check for validation. must be a card expiry date in MM/YY format
     - returns: Boolean value. True on successful validation, otherwise False on failed Validation.
     */
    public func validate(_ value: String) -> Bool {
        guard value.count > 4 else{
            return false
        }
        let date = value.replacingOccurrences(of: "/", with: "")
        let monthIndex = date.index(date.startIndex, offsetBy: 2)
        let Month = Int(date[..<monthIndex])
        
        let yearIndex = date.index(date.endIndex, offsetBy: -2)
        let Year = Int(date[yearIndex...])
        
        ///Holds the current year
        let thisYear = String(NSCalendar.current.component(Calendar.Component.year, from: Date()))
        let thisYearLast2 = thisYear.index(thisYear.startIndex, offsetBy: 2)
        let thisYearTwoDigits = Int(thisYear[thisYearLast2...])!
        
        
        return Month! <= 12 && Year! >= thisYearTwoDigits
        
    }
    
    /**
     Used to display error message when validation fails.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
    
}

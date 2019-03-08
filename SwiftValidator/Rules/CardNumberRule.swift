//
//  CardNumberRule.swift
//  Validator
//
//  Created by Boleigha Mark on 08/03/2018.
//  Copyright © 2017 jpotts18. All rights reserved.
//
import Foundation

/**
 `CardNumberRule` is a subclass of `Rule` that defines how a credit/debit's card number field is validated
 */
public class CardNumberRule: Rule {
    /// Error message to be displayed if validation fails.
    private var message: String
    /**
     Initializes `CardNumberRule` object with error message. Used to validate a card's expiry month.
     
     - parameter message: String of error message.
     - returns: An initialized `CardNumberRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message : String = "Card is Invalid"){
        self.message = message
    }
    
    /**
     Validates a field.
     
     - parameter value: String to check for validation.
     - returns: Boolean value. True on successful validation, otherwise False on failed Validation.
     */
    public func validate(_ value: String) -> Bool {
      let cardNoFull = value.replacingOccurrences(of: " ", with: "")
      
      guard CardState(fromNumber: cardNoFull) != .invalid else {
          return false
      }

      return true
    }
    
    /**
     Used to display error message when validation fails.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
    
}
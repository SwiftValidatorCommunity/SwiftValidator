//
//  CardExpiryMonthRule.swift
//  Validator
//
//  Created by Ifeanyi Ndu on 15/01/2017.
//  Copyright © 2017 jpotts18. All rights reserved.
//

import Foundation

public class CardExpiryMonthRule: Rule {
    
    private var message: String = "Must be a valid calendar month"
    
    public init(message : String = "Must be a valid calendar month"){
        
        self.message = message
        
    }
    
    public func validate(_ value: String) -> Bool {
        
        guard let month = Int(value) else {
            return false
        }
        return month >= 1 && month <= 12
    }
    
    public func errorMessage() -> String {
        return message
    }
    
}

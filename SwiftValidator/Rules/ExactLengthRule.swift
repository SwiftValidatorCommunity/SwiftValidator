//
//  ExactLengthRule.swift
//  Validator
//
//  Created by Jeff Potter on 2/3/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

public class ExactLengthRule : Rule {
    private var message : String = "Must be at most 16 characters long"
    private var length : Int
    
    public init(length: Int, message : String = "Must be exactly %ld characters long"){
        self.length = length
        self.message = NSString(format: message, self.length) as String
    }
    
    public func validate(value: String) -> Bool {
        return value.characters.count == length
    }
    
    public func errorMessage() -> String {
        return message
    }
}
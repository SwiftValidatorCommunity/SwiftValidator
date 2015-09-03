//
//  FloatRule.swift
//  Validator
//
//  Created by Cameron McCord on 5/5/15.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

public class FloatRule:Rule {
    
    private var message : String

    public init(message : String = "This must be a number with or without a decimal"){
        self.message = message
    }
    
    public func validate(value: String) -> Bool {
        let regex = NSRegularExpression(pattern: "[-+]?(\\d*[.])?\\d+", options: nil, error: nil)
        if let regex = regex {
            let match = regex.numberOfMatchesInString(value, options: nil, range: NSRange(location: 0, length: count(value)))
            return match == 1
        }
        return false
    }
    
    public func errorMessage() -> String {
        return message
    }
}
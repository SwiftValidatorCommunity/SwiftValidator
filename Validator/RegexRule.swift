//
//  RegexRule.swift
//  Validator
//
//  Created by Jeff Potter on 4/3/15.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

public class RegexRule : Rule {
    
    private var REGEX: String = "^(?=.*?[A-Z]).{8,}$"
    
    public init(regex: String){
        self.REGEX = regex
    }
    
    public func validate(value: String) -> Bool {
        if let test = NSPredicate(format: "SELF MATCHES %@", self.REGEX) {
            if test.evaluateWithObject(value) {
                return true
            }
        }
        return false
    }
    
    public func errorMessage() -> String {
        return "Invalid Regular Expression"
    }
}

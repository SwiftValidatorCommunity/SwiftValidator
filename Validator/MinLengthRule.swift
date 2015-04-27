//
//  LengthRule.swift
//  Validator
//
//  Created by Jeff Potter on 3/6/15.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

public class MinLengthRule: Rule {
    
    private var DEFAULT_LENGTH: Int = 3
    
    public init(){}
    
    public init(length: Int){
        self.DEFAULT_LENGTH = length
    }
    
    public func validate(value: String) -> Bool {
        return count(value) >= DEFAULT_LENGTH
    }
    
    public func errorMessage() -> String {
        return "Must be at least \(DEFAULT_LENGTH) characters long"
    }
}

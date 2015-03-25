//
//  LengthRule.swift
//  Validator
//
//  Created by Jeff Potter on 3/6/15.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation


class MinLengthRule : Rule {
    
    private let DEFAULT_MIN_LENGTH: Int
    
    init(){
        DEFAULT_MIN_LENGTH = 3
    }
    
    init(length:Int){
        self.DEFAULT_MIN_LENGTH = length
    }
    
    func validate(value: String) -> Bool {
        if count(value) < DEFAULT_MIN_LENGTH {
            return false
        }
        return true
    }
    
    func errorMessage() -> String {
        return "Must be at least \(DEFAULT_MIN_LENGTH) characters long"
    }
}

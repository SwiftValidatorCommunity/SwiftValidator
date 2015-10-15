//
//  MaxLengthRule.swift
//  Validator
//
//  Created by Guilherme Berger on 4/6/15.
//

import Foundation

public class MaxLengthRule: Rule {
    
    private var DEFAULT_LENGTH: Int = 16
    private var message : String = "Must be at most 16 characters long"
    
    public init(){}
    
    public init(length: Int, message : String = "Must be at most %ld characters long"){
        self.DEFAULT_LENGTH = length
        self.message = NSString(format: message, self.DEFAULT_LENGTH) as String
    }
        
    public func validate(value: String) -> Bool {
        return value.characters.count <= DEFAULT_LENGTH
    }
    
    public func errorMessage() -> String {
        return message
    }
}

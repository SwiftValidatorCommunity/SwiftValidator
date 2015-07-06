//
//  MaxLengthRule.swift
//  Validator
//
//  Created by Guilherme Berger on 4/6/15.
//

import Foundation

public class MaxLengthRule: Rule {
    
    private var DEFAULT_LENGTH: Int = 16
    
    public init(){}
    
    public init(length: Int){
        self.DEFAULT_LENGTH = length
    }
    
    public func validate(value: String) -> Bool {
        return value.characters.count <= DEFAULT_LENGTH
    }
    
    public func errorMessage() -> String {
        return "Must be at most \(DEFAULT_LENGTH) characters long"
    }
}

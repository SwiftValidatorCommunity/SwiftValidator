//
//  CharacterSetRule.swift
//  Validator
//
//  Created by Bhargav Gurlanka on 2/4/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

public class CharacterSetRule: Rule {
    
    private let characterSet: NSCharacterSet
    private var message: String
    
    public init(characterSet: NSCharacterSet, message: String = "Enter valid alpha") {
        self.characterSet = characterSet
        self.message = message
    }
    
    public func validate(value: String) -> Bool {
        for uni in value.unicodeScalars {
            if !characterSet.longCharacterIsMember(uni.value) {
                return false
            }
        }
        return true
    }
    
    public func errorMessage() -> String {
        return message
    }
}
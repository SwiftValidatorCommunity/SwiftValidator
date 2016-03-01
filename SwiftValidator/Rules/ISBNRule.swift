//
//  ISBNRule.swift
//  Validator
//
//  Created by Bhargav Gurlanka on 2/4/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

public class ISBNRule: Rule {
    
    private let message: String
    
    public init(message: String = "Enter valid ISBN number") {
        self.message = message
    }
    
    public func validate(value: String) -> Bool {
        
        guard let regex = try? NSRegularExpression(pattern: "[\\s-]", options: []) else {
            fatalError("Invalid ISBN sanitizing regex")
        }
        
        let sanitized = regex.stringByReplacingMatchesInString(value, options: [], range: NSMakeRange(0, value.characters.count), withTemplate: "")
        
        return ISBN10Validator().verify(sanitized) || ISBN13Validator().verify(sanitized)
    }
    
    public func errorMessage() -> String {
        return message;
    }
}

private protocol ISBNValidator {
    var regex: String { get }
    
    func verify(input: String) -> Bool
    func checkRegex(input: String) -> Bool
    func verifyChecksum(input: String) -> Bool
}

extension ISBNValidator {
    
    func verify(input: String) -> Bool {
        return checkRegex(input) && verifyChecksum(input)
    }
    
    func checkRegex(input: String) -> Bool {
        guard let _ = input.rangeOfString(regex, options: [.RegularExpressionSearch, .AnchoredSearch]) else  {
            return false
        }
        
        return true
    }
}

private struct ISBN10Validator: ISBNValidator {
    let regex = "^(?:[0-9]{9}X|[0-9]{10})$"
    
    private func verifyChecksum(input: String) -> Bool {
        var checksum = 0
        
        for i in 0..<9 {
            if let intCharacter = Int(String(input[input.startIndex.advancedBy(i)])) {
                checksum += (i + 1) * intCharacter
            }
        }
        
        if (input[input.startIndex.advancedBy(9)] == "X") {
            checksum += 10 * 10
        } else {
            if let intCharacter = Int(String(input[input.startIndex.advancedBy(9)])) {
                checksum += 10 * intCharacter
            }
        }
        
        return ((checksum % 11) == 0)
    }
}

private struct ISBN13Validator: ISBNValidator {
    let regex = "^(?:[0-9]{13})$"
    
    private func verifyChecksum(input: String) -> Bool {
        let factor = [1, 3]
        var checksum = 0
        
        for i in 0..<12 {
            if let intCharacter = Int(String(input[input.startIndex.advancedBy(i)])) {
                print("\(factor[i%2]) * \(intCharacter)")
                checksum += factor[i % 2] * intCharacter
            }
        }
        
        if let lastInt = Int(String(input[input.startIndex.advancedBy(12)])) {
            return (lastInt - ((10 - (checksum % 10)) % 10) == 0)
        }
        
        return false
    }
}
//
//  ZipCodeRule.swift
//  Validator
//
//  Created by Jeff Potter on 3/6/15.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

public class ZipCodeRule: Rule {
    private let REGEX: String
    
    init(){
        self.REGEX = "\\d{5}"
    }
    init(regex:String){
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
        return "Enter a valid 5 digit zipcode"
    }
    
}
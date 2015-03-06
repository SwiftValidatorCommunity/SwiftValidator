//
//  ZipCodeRule.swift
//  Validator
//
//  Created by Jeff Potter on 3/6/15.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

class ZipCodeRule: Rule {
    let REGEX = "\\d{5}"
    
    
    init(){}
    init(regex:String){
        self.REGEX = regex
    }
    
    var message: String {
        return "Enter a valid 5 digit zipcode"
    }
    
    func validate(value: String) -> Bool {
        if let zipTest = NSPredicate(format: "SELF MATCHES %@", REGEX) {
            if zipTest.evaluateWithObject(value) {
                return true
            }
            return false
        }
        return false
    }
    
    func errorMessage() -> String {
        return message
    }
    
}
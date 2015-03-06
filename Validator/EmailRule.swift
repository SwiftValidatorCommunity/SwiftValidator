//
//  EmailValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation

class EmailRule: Rule {
    
    let REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    
    init(){}
    
    init(regex:String){
        self.REGEX = regex
    }
    
    var message:String {
        return "Must be a valid email address"
    }
    
    func validate(value:String) -> Bool {
        
        if let emailTest = NSPredicate(format: "SELF MATCHES %@", REGEX) {
            if emailTest.evaluateWithObject(value) {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func errorMessage() -> String {
        return self.message
    }
}
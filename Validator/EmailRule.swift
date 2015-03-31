//
//  EmailValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation

public class EmailRule: Rule {
    
    var REGEX : String
    
    public init(){
        self.REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    }
    
    public init(regex:String){
        REGEX = regex
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
        return "Must be a valid email address"
    }
}
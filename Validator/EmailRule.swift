//
//  EmailValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

public class EmailRule: Rule {
    
    private let REGEX: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    
    init(){}
    
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
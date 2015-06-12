//
//  EmailValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

public class EmailRule: RegexRule {

    
    static let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    
    public convenience init(message : String = "Must be a valid email address"){
        self.init(regex: EmailRule.regex, message: message)
    }
}
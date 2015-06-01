//
//  ZipCodeRule.swift
//  Validator
//
//  Created by Jeff Potter on 3/6/15.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

public class ZipCodeRule: RegexRule {
    
    public convenience init(message : String = "Enter a valid 5 digit zipcode"){
        self.init(regex: "\\d{5}", message : message)
    }
}
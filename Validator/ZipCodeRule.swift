//
//  ZipCodeRule.swift
//  Validator
//
//  Created by Jeff Potter on 3/6/15.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

public class ZipCodeRule: RegexRule {
    
    public init(){
        super.init(regex: "\\d{5}")
    }
    
    override public init(regex: String) {
        super.init(regex: regex)
    }
    
    public override func errorMessage() -> String {
        return "Enter a valid 5 digit zipcode"
    }
    
}
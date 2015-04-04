//
//  PasswordValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/13/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

public class PasswordRule : RegexRule {
    
    // Alternative Regexes
    
    // 8 characters. One uppercase. One Lowercase. One number.
    // var PASSWORD_REGEX = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).{8,}$"
    //
    // no length. One uppercase. One lowercae. One number.
    // var PASSWORD_REGEX = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).*?$"
    
    public init(){
        super.init(regex: "^(?=.*?[A-Z]).{8,}$")
    }
    
    override public init(regex: String) {
        super.init(regex: regex)
    }
    
    override public func errorMessage() -> String {
        return "Must be 8 characters with 1 uppercase"
    }
    
}
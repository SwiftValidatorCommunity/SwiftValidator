//
//  PasswordValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/13/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation

class PasswordRule : Rule {

    // Alternative Regexes

    // 8 characters. One uppercase. One Lowercase. One number.
    // var PASSWORD_REGEX = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).{8,}$"
    //
    // no length. One uppercase. One lowercae. One number.
    // var PASSWORD_REGEX = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).*?$"
    
    // 8 characters. one uppercase
    
    var REGEX = "^(?=.*?[A-Z]).{8,}$"
    
    init(){}
    
    init(regex:String){
        self.REGEX = regex
    }
    
    var message:String {
        return "Must be 8 characters with 1 uppercase"
    }
    
    func validate(value: String) -> Bool {
        if let passwordTes = NSPredicate(format: "SELF MATCHES %@", REGEX) {
            if passwordTes.evaluateWithObject(value) {
                return true
            }
            return false
        }
        return false
    }
    
    func errorMessage() -> String {
        return self.message
    }
}
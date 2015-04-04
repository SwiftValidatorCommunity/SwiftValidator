//
//  FullNameValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/19/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation


public class FullNameRule : Rule {
    
    var message:String {
        return "Please provide a first & last name"
    }
    
    public func validate(value:String) -> Bool {
        
        var nameArray:[String] = split(value) { $0 == " " }
        if nameArray.count >= 2 {
            return true
        }
        return false
    }
    public func errorMessage() -> String {
        return message
    }
}
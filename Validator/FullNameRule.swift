//
//  FullNameValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/19/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation


public class FullNameRule : Rule {
    
    var message:String {
        return "Please provide a first & last name"
    }
    
    public init(){}
    
    public func validate(value: String) -> Bool {
        var nameArray: [String] = split(value) { $0 == " " }
        return nameArray.count >= 2
    }
    public func errorMessage() -> String {
        return message
    }
}
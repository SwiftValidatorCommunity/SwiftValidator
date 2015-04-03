//
//  FullNameValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/19/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation

class FullNameRule: Rule {
    
    var message:String {
        return "Please provide a first & last name"
    }
    
    func validate(value: String) -> Bool {
        var nameArray: [String] = split(value) { $0 == " " }
        return nameArray.count >= 2
    }
    
    func errorMessage() -> String {
        return message
    }
}
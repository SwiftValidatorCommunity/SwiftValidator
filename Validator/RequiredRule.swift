//
//  Required.swift
//  pyur-ios
//
//  Created by Jeff Potter on 12/22/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

public class RequiredRule: Rule {
    
    private var message : String 
    
    public init(message : String = "This field is required"){
        self.message = message
    }
    
    public func validate(value: String) -> Bool {
        return !value.isEmpty
    }
    
    public func errorMessage() -> String {
        return message
    }
}
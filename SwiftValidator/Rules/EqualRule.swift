//
//  EqualRule.swift
//  Validator
//
//  Created by Glauco Custódio on 1/12/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

public class EqualRule: Rule {
    private var desiredValue: String
    private var message: String
    
    public init(value: String, message: String? = nil) {
        self.desiredValue = value
        self.message = message != nil ? message! : "Value must be equal to \(desiredValue)"
    }
    
    public func validate(value: String) -> Bool {
        return !(value == desiredValue)
    }
    
    public func errorMessage() -> String {
        return self.message
    }
}
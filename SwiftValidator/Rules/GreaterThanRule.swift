//
//  GreaterTahnRule.swift
//  Validator
//
//  Created by Glauco Custódio on 1/12/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

public class GreaterThanRule: Rule {
    private var desiredValue: Double
    private var message: String
    
    public init(value: Double, message: String? = nil){
        self.desiredValue = value
        self.message = message != nil ? message! : "Value must be greater than \(desiredValue)"
    }
    
    public func validate(value: String) -> Bool {
        return (value as NSString).doubleValue > desiredValue
    }
    
    public func errorMessage() -> String {
        return self.message
    }
}
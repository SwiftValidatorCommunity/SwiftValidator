//
// Created by Sascha Wolf on 22/06/16.
// Copyright (c) 2016 jpotts18. All rights reserved.
//

import Foundation

public class DynamicRule: Rule {
    public typealias DynamicValidator = (value:String) -> Bool

    public var message: String
    public var validator: DynamicValidator

    public init(message: String = "The value is invalid", validator: DynamicValidator) {
        self.message = message
        self.validator = validator
    }

    public func validate(value: String) -> Bool {
        return validator(value: value)
    }

    public func errorMessage() -> String {
        return message
    }
}

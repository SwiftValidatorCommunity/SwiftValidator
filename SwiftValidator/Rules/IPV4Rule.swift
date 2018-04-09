//
//  IPV4Rule.swift
//  Validator
//
//  Created by Bhargav Gurlanka on 2/4/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

/**
 `IPV4Rule` is a subclass of RegexRule that defines how a IPV4 address validated.
 */
open class IPV4Rule: RegexRule {
    /// Regular expression string that is used to verify IPV4 address.
    static let regex = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"
    
    /**
     Initializes a `IPV4Rule` object to verify that field has text is an IPV4Rule address.
     
     - parameter message: String of error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message: String = "Must be a valid IPV4 address") {
        super.init(regex: IPV4Rule.regex, message: message)
    }
}

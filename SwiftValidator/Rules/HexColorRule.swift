//
//  HexColorRule.swift
//  Validator
//
//  Created by Bhargav Gurlanka on 2/4/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

/**
 `HexColorRule` is a subclass of `RegexRule`. It is used to verify whether a field is a hexadecimal color.
 */
open class HexColorRule: RegexRule {
    /// Regular expression string that is used to verify hexadecimal
    static let regex = "^#?([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$"

    /**
     Initializes a `HexaColorRule` object to verify that field has text in hexadecimal color format.
     
     - parameter message: String of error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message: String = "Invalid regular expression") {
        super.init(regex: HexColorRule.regex, message: message)
    }
}

//
//  HexColorRule.swift
//  Validator
//
//  Created by Bhargav Gurlanka on 2/4/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

public class HexColorRule: RegexRule {
    static let regex = "^#?([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$"

    public init(message: String = "Invalid regular expression") {
        super.init(regex: HexColorRule.regex, message: message)
    }
}
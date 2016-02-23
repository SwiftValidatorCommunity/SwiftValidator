//
//  Sanitizers.swift
//  Validator
//
//  Created by David Patterson on 2/22/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

public class TrimLeadingAndTrailingSpacesSanitizer: Sanitizer {
    public init() {}
    public func sanitize(textField: UITextField) {
        textField.text = textField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}
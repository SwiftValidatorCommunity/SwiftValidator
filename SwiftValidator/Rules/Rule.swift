//
//  Validation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

public protocol Rule {
    func validate(value: String) -> Bool
    func errorMessage() -> String
}

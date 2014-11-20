//
//  MaxLengthValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation

class MaxLengthValidation: Validation {
    let DEFAULT_MAX_LENGTH = 25
    
    func validate(value: String) -> (Bool, ValidationErrorType) {
        if countElements(value) > DEFAULT_MAX_LENGTH {
            return (false, .MaxLength)
        }
        return (true, .NoError)
    }
}
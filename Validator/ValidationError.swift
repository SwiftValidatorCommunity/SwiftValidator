//
//  File.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation
import UIKit

class ValidationError {
    let textField: UITextField
    let errorMessage: String
    var errorLabel: UILabel?
    
    init(textField: UITextField, error: String) {
        self.textField = textField
        self.errorMessage = error
    }
}
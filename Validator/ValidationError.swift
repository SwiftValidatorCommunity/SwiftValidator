//
//  File.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation
import UIKit

public class ValidationError {
    public let textField:UITextField
    public var errorLabel:UILabel?
    public let errorMessage:String
    
    public init(textField:UITextField, error:String){
        self.textField = textField
        self.errorMessage = error
    }
    
}
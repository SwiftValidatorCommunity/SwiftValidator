//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

/**
 The `ValidationError` class is used for representing errors of a failed validation. It contains the text field, error label, and error message of a failed validation.
 */
public class ValidationError: NSObject {
    /// the textField of the field
    public let textField:UITextField
    /// the error label of the field
    public var errorLabel:UILabel?
    /// the error message of the field
    public let errorMessage:String
    
    /**
     Initializes `ValidationError` object with a textField and error.
     - parameter textField: UITextField that holds textField.
     - parameter errorMessage: String that holds error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(textField:UITextField, error:String){
        self.textField = textField
        self.errorMessage = error
    }
    
    /**
     Initializes ValidationError object with a textField, errorLabel, and errorMessage.
     - parameter textField: UITextField that holds textField.
     - parameter errorLabel: UILabel that holds error label.
     - parameter errorMessage: String that holds error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(textField:UITextField, errorLabel:UILabel?, error:String){
        self.textField = textField
        self.errorLabel = errorLabel
        self.errorMessage = error
    }
}
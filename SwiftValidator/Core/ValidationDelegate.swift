//
//  ValidationDelegate.swift
//  Validator
//
//  Created by David Patterson on 1/2/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation
import UIKit
/**
 Protocol for `ValidationDelegate` adherents, which comes with two required methods that are called depending on whether validation succeeded or failed.
 */
@objc public protocol ValidationDelegate {
    /**
     This method will be called on delegate object when validation is successful.
     - returns: No return value.
     */
    optional func validationSuccessful()
    /**
     This method will be called on delegate object when validation fails.
     - returns: No return value.
     */
    optional func validationFailed(errors: [UITextField:ValidationError])
    /// This method is called as soon a validation starts. Should be used to do things like disable buttons, textfields once validation is started.
    func willValidate()
    /// This method is called just before validator's fields are validated. Should return true if validation is to be continued. Should return
    /// false if validation should not run.
    func shouldValidate() -> Bool
    /// This method is called after validator's fields have been validated.
    func didValidate()
    /// This method is called after when validation does not run because preconditions have not been met.
    func failedBeforeValidation()
}

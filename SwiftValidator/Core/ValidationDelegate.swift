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
     This delegate method will be called on delegate object when validation is successful.
     - returns: No return value.
     */
    func validationSuccessful()
    /**
     This delegae method will be called on delegate object when validation fails.
     - returns: No return value.
     */
    func validationFailed(errors: [UITextField:ValidationError])
    /**
     This delegate method is called on fields that require remote validation.
     - parameter text: String to is sent to server to be validated.
     - parameter urlString: String of url endpoint that will be used to validate text.
     - parameter completion: closure that holds the result of the server validation request. Should be set to true if server validation was a success. Should return false if server validation failed.
     - returns: No return value.
     */
    optional func remoteValidationRequest(text: String, urlString: String, completion:(result: Bool) -> Void)
}

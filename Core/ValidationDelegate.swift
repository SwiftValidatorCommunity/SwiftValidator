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
public protocol ValidationDelegate {
    /**
     This method will be called on delegate object when validation is successful.
     
     - returns: No return value.
     */
    func validationSuccessful()
    /**
     This method will be called on delegate object when validation fails.
     
     - returns: No return value.
     */
    func validationFailed(_ errors: [(Validatable, ValidationError)])
}

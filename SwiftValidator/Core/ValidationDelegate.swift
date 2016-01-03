//
//  ValidationDelegate.swift
//  Validator
//
//  Created by David Patterson on 1/2/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

@objc public protocol ValidationDelegate {
    func validationSuccessful()
    func validationFailed(errors: [UITextField:ValidationError])
}
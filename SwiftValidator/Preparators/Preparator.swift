//
//  Preparator.swift
//  Validator
//
//  Created by Łukasz Osiennik on 30/10/15.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

public protocol Preparator {
    
    func prepare(textField: UITextField) -> Bool
}

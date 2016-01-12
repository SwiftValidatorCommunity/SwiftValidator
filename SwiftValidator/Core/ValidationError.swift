//
//  File.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation
import UIKit

public class ValidationError: NSObject {
    public let textField: UITextField?
  	public let segmentedControl: UISegmentedControl?
    public var errorLabel: UILabel?
    public let errorMessage: String
    
    public init(textField: UITextField, error:String){
        self.textField = textField
        self.errorMessage = error
   		self.segmentedControl = nil
    }
    
    public init(textField: UITextField, errorLabel:UILabel?, error:String){
        self.textField = textField
        self.errorLabel = errorLabel
        self.errorMessage = error
   		self.segmentedControl = nil
    }
    
    public init(segmentedControl: UISegmentedControl, error: String){
        self.segmentedControl = segmentedControl
        self.errorMessage = error
        self.textField = nil
    }
}
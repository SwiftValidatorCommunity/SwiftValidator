//
//  TrimSpacesPreparator.swift
//  Validator
//
//  Created by Łukasz Osiennik on 30/10/15.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation

public class TrimSpacesPreparator: Preparator {
    
    public init() {
        
    }
    
    public func prepare(textField: UITextField) -> Bool {
        
        let previousText = textField.text ?? ""
        
        let currentText = previousText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        textField.text = currentText
        
        return currentText != previousText;
    }
}

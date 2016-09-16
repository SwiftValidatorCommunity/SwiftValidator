//
//  ValidatorDictionary.swift
//  Validator
//
//  Created by Deniz Adalar on 04/05/16.
//  Copyright © 2016 jpotts18. All rights reserved.
//

import Foundation

public struct ValidatorDictionary<T> : SequenceType {
    
    private var innerDictionary: [ObjectIdentifier: T] = [:];
    
    public subscript(key: ValidatableField?) -> T? {
        get {
            if let key = key {
                return innerDictionary[ObjectIdentifier(key)];
            } else {
                return nil;
            }
        }
        set(newValue) {
            if let key = key {
                innerDictionary[ObjectIdentifier(key)] = newValue;
            }
        }
    }
    
    public mutating func removeAll() {
        innerDictionary.removeAll()        
    }
    
    public mutating func removeValueForKey(key: ValidatableField) {
        innerDictionary.removeValueForKey(ObjectIdentifier(key))
    }
    
    public var isEmpty: Bool {
        return innerDictionary.isEmpty
    }
    
    public func generate() -> DictionaryGenerator<ObjectIdentifier ,T> {
        return innerDictionary.generate()
    }
}

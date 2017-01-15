//
//  CardExpiryYearRule.swift
//  Validator
//
//  Created by Ifeanyi Ndu on 15/01/2017.
//  Copyright © 2017 jpotts18. All rights reserved.
//

import Foundation

public class CardExpiryYearRule: Rule {

    private var message: String = "Must be within 3 years of validity"

    //change to preferred validity period
    private var MAX_VALIDITY: Int = 3

    public init(message : String = "Must be within 3 years of validity"){

        self.message = message

    }

    public func validate(_ value: String) -> Bool {

        let thisYear = NSCalendar.current.component(Calendar.Component.year, from: Date())

        guard let year = Int(value) else {
            return false
        }

        return year >= thisYear && year <= thisYear + MAX_VALIDITY
    }

    public func errorMessage() -> String {
        return message
    }

}

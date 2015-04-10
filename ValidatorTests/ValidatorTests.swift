//
//  ValidatorTests.swift
//  ValidatorTests
//
//  Created by Jeff Potter on 11/20/14.
//  Copyright (c) 2014 jpotts18. All rights reserved.
//

import UIKit
import XCTest
import Validator

class ValidatorTests: XCTestCase {
    
    let USERNAME_REGEX = "^[a-z0-9_-]{3,16}$"
    
    let VALID_ZIP = "12345"
    let INVALID_ZIP = "1234"
    
    let VALID_EMAIL = "jiggy@gmail.com"
    let INVALID_EMAIL = "This is not a valid email"
    
    let CONFIRM_TXT_FIELD = UITextField()
    let CONFIRM_TEXT = "Confirm this!"
    let CONFIRM_TEXT_DIFF = "I am not the same as the string above"
    
    let VALID_PASSWORD = "Super$ecret"
    let INVALID_PASSWORD = "abc"
    
    let LEN_3 = "hey"
    let LEN_5 = "Howdy"
    let LEN_20 = "Paint the cat orange"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: Required
    
    func testRequired() {
        XCTAssertTrue(RequiredRule().validate("Something"), "Required should be valid")
    }
    
    func testRequiredInvalid() {
        XCTAssertFalse(RequiredRule().validate(""), "Required should be invalid")
    }
    
    // MARK: Regex
    
    func testRegex(){
        XCTAssertTrue(RegexRule(regex: USERNAME_REGEX).validate("darth_vader8"), "RegexRule should be valid")
    }
    
    func testRegexInvalid(){
        XCTAssertFalse(RegexRule(regex: USERNAME_REGEX).validate("DarthVader"), "RegexRule should be invalid")
    }
    
    // MARK: Zipcode
    
    func testZipCode() {
        XCTAssertTrue(ZipCodeRule().validate(VALID_ZIP), "Zipcode should be valid")
    }
    
    func testZipCodeInvalid() {
        XCTAssertFalse(ZipCodeRule().validate(INVALID_ZIP), "Zipcode should be invalid")
    }
    
    // MARK: Email
    
    func testEmail() {
        XCTAssertTrue(EmailRule().validate(VALID_EMAIL), "Email should be valid")
    }
    
    func testEmailInvalid() {
        XCTAssertFalse(EmailRule().validate(INVALID_EMAIL), "Email should be invalid")
    }
    
    // MARK: Confirm against field
    
    func testConfirmSame(){
        CONFIRM_TXT_FIELD.text = CONFIRM_TEXT
        XCTAssertTrue(ConfirmationRule(confirmField: CONFIRM_TXT_FIELD).validate(CONFIRM_TEXT), "Should confirm successfully")
    }
    
    func testConfirmDifferent() {
        CONFIRM_TXT_FIELD.text = CONFIRM_TEXT
        XCTAssertFalse(ConfirmationRule(confirmField: CONFIRM_TXT_FIELD).validate(CONFIRM_TEXT_DIFF), "Should fail confirm")
    }
    
    // MARK: Password
    
    func testPassword() {
        XCTAssertTrue(PasswordRule().validate(VALID_PASSWORD), "Password should be valid")
    }
    
    func testPasswordInvalid(){
        XCTAssertFalse(EmailRule().validate(INVALID_PASSWORD), "Password is invalid")
    }
    
    // MARK: Max Length
    
    func testMaxLength(){
        XCTAssertTrue(MaxLengthRule().validate(LEN_3),"Max Length should be valid")
    }
    
    func testMaxLengthInvalid(){
        XCTAssertFalse(MaxLengthRule().validate(LEN_20),"Max Length should be invalid")
    }
    
    func testMaxLengthParameterAndGreaterThan(){
        XCTAssertTrue(MaxLengthRule(length: 20).validate(LEN_20), "Max Length should be 20 and <= length")
    }

    // MARK: Min Length
    func testMinLength(){
        XCTAssertTrue(MinLengthRule().validate(LEN_3),"Min Length should be valid")
    }
    
    func testMinLengthInvalid(){
        XCTAssertFalse(MinLengthRule().validate("no"),"Min Length should be Invalid")
    }
    
    func testMinLengthWithParameter(){
        XCTAssertTrue(MinLengthRule(length: 5).validate(LEN_5), "Min Len should be set to 5 and >= length")
    }

    // MARK: Full Name
    
    func testFullName(){
        XCTAssertTrue(FullNameRule().validate("Jeff Potter"), "Full Name should be valid")
    }

    func testFullNameWith3Names(){
        XCTAssertTrue(FullNameRule().validate("Jeff Van Buren"), "Full Name should be valid")
    }
    
    func testFullNameInvalid(){
        XCTAssertFalse(FullNameRule().validate("Carl"), "Full Name should be invalid")
    }
    
}

//
//  SwiftValidatorTests.swift
//  SwiftValidatorTests
//
//  Created by Jeff Potter on 11/20/14.
//  Copyright (c) 2014 jpotts18. All rights reserved.
//

import UIKit
import XCTest
import Validator // example app
import SwiftValidator // framework

class SwiftValidatorTests: XCTestCase {
    
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
    
    let VALID_FLOAT = "1234.444"
    let INVALID_FLOAT = "1234.44.44"
    
    let LEN_3 = "hey"
    let LEN_5 = "Howdy"
    let LEN_20 = "Paint the cat orange"
    
    let REGISTER_TXT_FIELD = UITextField()
    let REGISTER_VALIDATOR = Validator()
    let REGISTER_RULES = [Rule]()
    
    let UNREGISTER_TXT_FIELD = UITextField()
    let UNREGISTER_VALIDATOR = Validator()
    let UNREGISTER_RULES = [Rule]()
    
    let UNREGISTER_ERRORS_TXT_FIELD = UITextField()
    let UNREGISTER_ERRORS_VALIDATOR = Validator()
    
    let ERROR_LABEL = UILabel()
    
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
    
    func testRequiredMessage() {
        XCTAssertNotNil(RequiredRule().errorMessage())
    }
    
    // MARK: Regex
    
    func testRegex(){
        XCTAssertTrue(RegexRule(regex: USERNAME_REGEX).validate("darth_vader8"), "RegexRule should be valid")
    }
    
    func testRegexInvalid(){
        XCTAssertFalse(RegexRule(regex: USERNAME_REGEX).validate("DarthVader"), "RegexRule should be invalid")
    }
    
    func testRegexMessage() {
        XCTAssertNotNil(RegexRule(regex: USERNAME_REGEX).errorMessage())
    }
    
    // MARK: Zipcode
    
    func testZipCode() {
        XCTAssertTrue(ZipCodeRule().validate(VALID_ZIP), "Zipcode should be valid")
    }
    
    func testZipCodeInvalid() {
        XCTAssertFalse(ZipCodeRule().validate(INVALID_ZIP), "Zipcode should be invalid")
    }
    
    func testZipCodeMessage() {
        XCTAssertNotNil(ZipCodeRule().errorMessage())
    }
    
    // MARK: Email
    
    func testEmail() {
        XCTAssertTrue(EmailRule().validate(VALID_EMAIL), "Email should be valid")
    }
    
    func testEmailInvalid() {
        XCTAssertFalse(EmailRule().validate(INVALID_EMAIL), "Email should be invalid")
    }
    
    func testEmailMessage() {
        XCTAssertNotNil(EmailRule().errorMessage())
    }
    
    // MARK: Float
    
    func testFloat() {
        XCTAssert(FloatRule().validate(VALID_FLOAT), "Float should be valid")
    }
    
    func testFloatInvalid() {
        XCTAssert(!FloatRule().validate(INVALID_FLOAT), "Float should be invalid")
        XCTAssert(!FloatRule().validate(VALID_EMAIL), "Float should be invalid")
    }
    
    func testFloatMessage() {
        XCTAssertNotNil(FloatRule().errorMessage())
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
    
    func testConfirmMessage() {
        CONFIRM_TXT_FIELD.text = CONFIRM_TEXT
        XCTAssertNotNil(ConfirmationRule(confirmField: CONFIRM_TXT_FIELD).errorMessage())
    }
    
    // MARK: Password
    
    func testPassword() {
        XCTAssertTrue(PasswordRule().validate(VALID_PASSWORD), "Password should be valid")
    }
    
    func testPasswordInvalid(){
        XCTAssertFalse(PasswordRule().validate(INVALID_PASSWORD), "Password is invalid")
    }
    
    func testPasswordMessage() {
        XCTAssertNotNil(PasswordRule().errorMessage())
    }
    
    func testPhoneNumber() {
        XCTAssertTrue(PhoneNumberRule().validate("1234567890"), "Phone number should valid")
    }
    
    func testPhoneNumberInvalid() {
        XCTAssertFalse(PhoneNumberRule().validate("12345678901"), "Phone number should be invalid")
    }
    
    func testPhoneNumberMessage() {
        XCTAssertNotNil(PhoneNumberRule().errorMessage())
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
    
    func testMaxLengthMessage() {
        XCTAssertNotNil(MaxLengthRule(length: 20).errorMessage())
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
    
    func testMinLengthMessage() {
        XCTAssertNotNil(MinLengthRule(length: 5).errorMessage())
    }
    
    func testExactLength(){
        XCTAssertTrue(ExactLengthRule(length: 5).validate(LEN_5), "Exact Len should be exactly 5")
    }
    
    func testExactLengthInvalidGreaterThan(){
        XCTAssertFalse(ExactLengthRule(length: 6).validate(LEN_5), "Exact Len should be Invalid")
    }

    func testExactLengthInvalidLessThan(){
        XCTAssertFalse(ExactLengthRule(length: 4).validate(LEN_5), "Exact Len should be Invalid")
    }
    
    func testExactLengthMessage() {
        XCTAssertNotNil(ExactLengthRule(length: 4).errorMessage())
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
    
    // MARK: ISBN
    
    func testValidISBN10() {
        let validISBN10 = ["3836221195", "3-8362-2119-5", "3 8362 2119 5" , "1617290858", "1-61729-085-8", "1 61729 085-8" , "0007269706", "0-00-726970-6", "0 00 726970 6" , "3423214120", "3-423-21412-0", "3 423 21412 0", "340101319X", "3-401-01319-X", "3 401 01319 X"]
        
        for ISBN10 in validISBN10 {
            XCTAssertTrue(ISBNRule().validate(ISBN10), "\(ISBN10) should be valid")
        }
    }
    
    func testInvalidISBN10() {
        let invalidISBN10 = ["3423214121", "3-423-21412-1", "3 423 21412 1"]
        
        for ISBN10 in invalidISBN10 {
            XCTAssertFalse(ISBNRule().validate(ISBN10), "\(ISBN10) should be invalid")
        }
    }
    
    // MARK: HexColor
    
    func testValidHexColors() {
        let validHexes = ["#ff0034", "#CCCCCC", "fff", "#f00"]
        for hex in validHexes {
            XCTAssertTrue(HexColorRule().validate(hex), "\(hex) should be a valid Hex")
        }
    }
    
    func testInvalidHexColors() {
        let validHexes = ["#ff", "fff0", "#ff12FG", ""]
        for hex in validHexes {
            XCTAssertFalse(HexColorRule().validate(hex), "\(hex) should be invalid Hex")
        }
    }
    
    //MARK: IPV4

    func testValidIPV4() {
        let validIPV4 = ["127.0.0.1" , "0.0.0.0" , "255.255.255.255" , "1.2.3.4"]
        for ipv4 in validIPV4 {
            XCTAssertTrue(IPV4Rule().validate(ipv4), "\(ipv4) should be a valid IPV4 address")
        }
    }
    
    func testInvalidIPV4() {
        let invalidIPV4 = ["::1" , "2001:db8:0000:1:1:1:1:1" , "::ffff:127.0.0.1"]
        for ipv4 in invalidIPV4 {
            XCTAssertFalse(IPV4Rule().validate(ipv4), "\(ipv4) should be invalid IPV4 address")
        }
    }
    
    //MARK: AlphaNumeric
    
    func testValidAlphaNumeric() {
        let validAlphaNumeric = ["abc123", "A1B2C35555"]
        for alphaNum in validAlphaNumeric {
            XCTAssertTrue(AlphaNumericRule().validate(alphaNum), "\(alphaNum) should be a valid alpha numeric string")
        }
    }
    
    func testInvalidAlphaNumeric() {
        let invalidAlphaNumeric = ["abc ", "!!!!!", "ABC@DAGQW%!^$@%"]
        for alphaNum in invalidAlphaNumeric {
            XCTAssertFalse(AlphaNumericRule().validate(alphaNum), "\(alphaNum) should be invalid alpha numeric string")
        }
    }
    
    //MARK: Alpha
    
    func testValidAlpha() {
        let validAlphaStrings = ["abc", "ABCDEFG", "AabeVsDvaW"]
        for alpha in validAlphaStrings {
            XCTAssertTrue(AlphaRule().validate(alpha), "\(alpha) should be valid alpha string")
        }
    }
    
    func testInvalidAlpha() {
        let invalidAlphaStrings = ["abc1", "  foo  "]
        for alpha in invalidAlphaStrings {
            XCTAssertFalse(AlphaRule().validate(alpha), "\(alpha) should be invalid alpha string")
        }
    }
    
    // MARK: Register Field
    
    func testRegisterField(){
        REGISTER_VALIDATOR.registerField(REGISTER_TXT_FIELD, rules: REGISTER_RULES)
        XCTAssert(REGISTER_VALIDATOR.validations[REGISTER_TXT_FIELD] != nil, "Textfield should register")
    }
    
    func testUnregisterField(){
        UNREGISTER_VALIDATOR.registerField(UNREGISTER_TXT_FIELD, rules: UNREGISTER_RULES)
        UNREGISTER_VALIDATOR.unregisterField(UNREGISTER_TXT_FIELD)
        XCTAssert(UNREGISTER_VALIDATOR.validations[UNREGISTER_TXT_FIELD] == nil, "Textfield should unregister")
    }
    
    func testUnregisterError(){
        UNREGISTER_ERRORS_VALIDATOR.registerField(UNREGISTER_ERRORS_TXT_FIELD, rules: [EmailRule()])
        UNREGISTER_ERRORS_TXT_FIELD.text = INVALID_EMAIL
        UNREGISTER_ERRORS_VALIDATOR.validate { (errors) -> Void in
            XCTAssert(errors.count == 1, "Should come back with errors")
        }
        UNREGISTER_ERRORS_VALIDATOR.unregisterField(UNREGISTER_ERRORS_TXT_FIELD)
        UNREGISTER_ERRORS_VALIDATOR.validate { (errors) -> Void in
            XCTAssert(errors.count == 0, "Should not come back with errors")
        }
    }
    
    // MARK: Validate Functions
    
    func testValidateWithCallback() {
        REGISTER_VALIDATOR.registerField(REGISTER_TXT_FIELD, rules: [EmailRule()])
        REGISTER_TXT_FIELD.text = VALID_EMAIL
        REGISTER_VALIDATOR.validate { (errors) -> Void in
            XCTAssert(errors.count == 0, "Should not come back with errors")
        }
        REGISTER_TXT_FIELD.text = INVALID_EMAIL
        REGISTER_VALIDATOR.validate { (errors) -> Void in
            XCTAssert(errors.count == 1, "Should come back with 1 error")
        }
    }
    
    func testValidateSingleField() {
        REGISTER_VALIDATOR.registerField(REGISTER_TXT_FIELD, rules: [EmailRule()])
        REGISTER_TXT_FIELD.text = VALID_EMAIL
        REGISTER_VALIDATOR.validateField(REGISTER_TXT_FIELD) { error in
            XCTAssert(error == nil, "Should not present error")
        }
        REGISTER_TXT_FIELD.text = INVALID_EMAIL
        REGISTER_VALIDATOR.validateField(REGISTER_TXT_FIELD) { error in
            XCTAssert(error?.errorMessage.count ?? 0 > 0, "Should state 'invalid email'")
        }
    }
    
    // MARK: Validate error field gets it's text set to the error, if supplied
    
    func testNoErrorMessageSet() {
        REGISTER_VALIDATOR.registerField(REGISTER_TXT_FIELD, errorLabel: ERROR_LABEL, rules: [EmailRule()])
        REGISTER_TXT_FIELD.text = VALID_EMAIL
        REGISTER_VALIDATOR.validate { (errors) -> Void in
            XCTAssert(errors.count == 0, "Should not come back with errors")
        }
    }
    
    func testErrorMessageSet() {
        REGISTER_VALIDATOR.registerField(REGISTER_TXT_FIELD, errorLabel: ERROR_LABEL, rules: [EmailRule()])
        var successCount = 0
        var errorCount = 0
        REGISTER_VALIDATOR.styleTransformers(success: { (validationRule) -> Void in
            successCount+=1
            }) { (validationError) -> Void in
                errorCount+=1
        }
        REGISTER_TXT_FIELD.text = INVALID_EMAIL
        REGISTER_VALIDATOR.validate { (errors) -> Void in
            XCTAssert(errors.count == 1, "Should come back with errors")
            XCTAssert(errorCount == 1, "Should have called the error style transform once")
            XCTAssert(successCount == 0, "Should not have called the success style transform as there are no successful fields")
        }
    }
    
    func testErrorMessageSetAndThenUnset() {
        REGISTER_VALIDATOR.registerField(REGISTER_TXT_FIELD, errorLabel: ERROR_LABEL, rules: [EmailRule()])
        
        var successCount = 0
        var errorCount = 0
        REGISTER_VALIDATOR.styleTransformers(success: { (validationRule) -> Void in
            successCount+=1
            }) { (validationError) -> Void in
                errorCount+=1
        }
        
        REGISTER_TXT_FIELD.text = INVALID_EMAIL
        REGISTER_VALIDATOR.validate { (errors) -> Void in
            XCTAssert(errors.count == 1, "Should come back with errors")
            XCTAssert(errorCount == 1, "Should have called the error style transform once")
            XCTAssert(successCount == 0, "Should not have called the success style transform as there are no successful fields")
            self.REGISTER_TXT_FIELD.text = self.VALID_EMAIL
            self.REGISTER_VALIDATOR.validate { (errors) -> Void in
                XCTAssert(errors.count == 0, "Should not come back with errors: \(errors)")
                XCTAssert(successCount == 1, "Should have called the success style transform once")
                XCTAssert(errorCount == 1, "Should not have called the error style transform again")
            }
        }
    }
    
    func testTextFieldBorderColorNotSet() {
        REGISTER_VALIDATOR.registerField(REGISTER_TXT_FIELD, errorLabel: ERROR_LABEL, rules: [EmailRule()])
        REGISTER_TXT_FIELD.text = INVALID_EMAIL
        REGISTER_VALIDATOR.validate { (errors) -> Void in
            XCTAssert(errors.count == 1, "Should come back with errors")
            XCTAssert(!(self.REGISTER_TXT_FIELD.layer.borderColor! == UIColor.red.cgColor), "Color shouldn't get set at all")
        }
    }
}

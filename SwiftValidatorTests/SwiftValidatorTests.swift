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
    
    // MARK: Float
    
    func testFloat() {
        XCTAssert(FloatRule().validate(VALID_FLOAT), "Float should be valid")
    }
    
    func testFloatInvalid() {
        XCTAssert(!FloatRule().validate(INVALID_FLOAT), "Float should be invalid")
        XCTAssert(!FloatRule().validate(VALID_EMAIL), "Float should be invalid")
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
    
    func testPhoneNumber() {
        XCTAssertTrue(PhoneNumberRule().validate("1234567890"), "Phone number should valid")
    }
    
    func testPhoneNumberInvalid() {
        XCTAssertFalse(PhoneNumberRule().validate("12345678901"), "Phone number should be invalid")
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
    
    func testExactLength(){
        XCTAssertTrue(ExactLengthRule(length: 5).validate(LEN_5), "Exact Len should be exactly 5")
    }
    
    func testExactLengthInvalidGreaterThan(){
        XCTAssertFalse(ExactLengthRule(length: 6).validate(LEN_5), "Exact Len should be Invalid")
    }

    func testExactLengthInvalidLessThan(){
        XCTAssertFalse(ExactLengthRule(length: 4).validate(LEN_5), "Exact Len should be Invalid")
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
            XCTAssert(error?.errorMessage.characters.count > 0, "Should state 'invalid email'")
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
            successCount++
            }) { (validationError) -> Void in
                errorCount++
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
            successCount++
            }) { (validationError) -> Void in
                errorCount++
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
            XCTAssert(!CGColorEqualToColor(self.REGISTER_TXT_FIELD.layer.borderColor, UIColor.redColor().CGColor), "Color shouldn't get set at all")
        }
    }
}

//
//  ViewController.swift
//  Validator
//
//  Created by Jeff Potter on 11/20/14.
//  Copyright (c) 2014 jpotts18. All rights reserved.
//

import Foundation
import UIKit
import SwiftValidator

class ViewController: UIViewController , ValidationDelegate, UITextFieldDelegate {

    // TextFields
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var emailConfirmTextField: UITextField!
    
    // Error Labels
    @IBOutlet weak var fullNameErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var phoneNumberErrorLabel: UILabel!
    @IBOutlet weak var zipcodeErrorLabel: UILabel!
    @IBOutlet weak var emailConfirmErrorLabel: UILabel!
    @IBOutlet weak var agreementStatus: UISwitch!
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "hideKeyboard"))
        
        validator.styleTransformers(success:{ (validationRule) -> Void in
                // clear error label
                validationRule.errorLabel?.hidden = true
                validationRule.errorLabel?.text = ""
                validationRule.textField.layer.borderColor = UIColor.greenColor().CGColor
                validationRule.textField.layer.borderWidth = 0.5
            
            }, error:{ (validationError) -> Void in
                validationError.errorLabel?.hidden = false
                validationError.errorLabel?.text = validationError.errorMessage
                validationError.textField.layer.borderColor = UIColor.redColor().CGColor
                validationError.textField.layer.borderWidth = 1.0
        })
        
        validator.registerField(fullNameTextField, errorLabel: fullNameErrorLabel , rules: [RequiredRule(), FullNameRule()], sanitizers: [TrimLeadingAndTrailingSpacesSanitizer()])
        validator.registerField(emailTextField, errorLabel: emailErrorLabel, rules: [RequiredRule(), EmailRule()])
        validator.registerField(emailConfirmTextField, errorLabel: emailConfirmErrorLabel, rules: [RequiredRule(), ConfirmationRule(confirmField: emailTextField)])
        validator.registerField(phoneNumberTextField, errorLabel: phoneNumberErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 9)])
        validator.registerField(zipcodeTextField, errorLabel: zipcodeErrorLabel, rules: [RequiredRule(), ZipCodeRule()])
        // Set validator delegate
        validator.delegate = self
    }

    @IBAction func submitTapped(sender: AnyObject) {
        print("Validating...")
        validator.validate()
    }

    // MARK: ValidationDelegate Methods
    
    func willValidate() {
        print("Prepare validator for validation")
    }
    
    func validationSuccessful() {
        print("Validation Success!")
        let alert = UIAlertController(title: "Success", message: "You are validated!", preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    
    func validationFailed(errors:[UITextField:ValidationError]) {
        print("Validation FAILED!")
    }
    
    func shouldValidate() -> Bool {
        // Allow user to check that any preconditions are met before validation
        // Good place to validate things other than UITextField
        if !agreementStatus.on {
            return false
        }
        return true
    }
    
    func failedBeforeValidation() {
        // perform any style transformations
        print("validation failed before running")
    }
    
    func didValidate() {
        // perform custom post validation
        print("validationDidRun called")
    }
    
    func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    // MARK: Validate single field
    // Don't forget to use UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
            validator.validateField(textField){ error in
                if error == nil {
                    // Field validation was successful
                } else {
                    // Validation error occurred
                }
            }
        return true
    }
}
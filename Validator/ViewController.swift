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
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "hideKeyboard"))
        
        validator.styleTransformers(success:{ (validationRule) -> Void in
            print("here")
                // clear error label
                validationRule.errorLabel?.hidden = true
                validationRule.errorLabel?.text = ""
                validationRule.textField.layer.borderColor = UIColor.greenColor().CGColor
                validationRule.textField.layer.borderWidth = 0.5
            
            }, error:{ (validationError) -> Void in
                print("error")
                validationError.errorLabel?.hidden = false
                validationError.errorLabel?.text = validationError.errorMessage
                validationError.textField.layer.borderColor = UIColor.redColor().CGColor
                validationError.textField.layer.borderWidth = 1.0
        })
        
        validator.registerField(fullNameTextField, errorLabel: fullNameErrorLabel , rules: [RequiredRule(), FullNameRule()])
        validator.registerField(emailTextField, errorLabel: emailErrorLabel, rules: [RequiredRule(), EmailRule()], remoteInfo: (urlString: "http://localhost:8000/emails/", error: "Email already in use"))
        validator.registerField(emailConfirmTextField, errorLabel: emailConfirmErrorLabel, rules: [RequiredRule(), ConfirmationRule(confirmField: emailTextField)])
        validator.registerField(phoneNumberTextField, errorLabel: phoneNumberErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 9)])
        validator.registerField(zipcodeTextField, errorLabel: zipcodeErrorLabel, rules: [RequiredRule(), ZipCodeRule()])
        validator.delegate = self
    }

    @IBAction func submitTapped(sender: AnyObject) {
        print("Validating...")
        validator.validate()
    }
    
    func simulateRemoteRequest(seconds: Int64, completion: (result: Bool) -> Void) {
        print("Simulating \(seconds) second server request...")
        // Set number of seconds before "request" is finished
        let triggerTime = (Int64(NSEC_PER_SEC) * seconds)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            // For example purposes, if user does not enter David Patterson as full name,
            // the email they tried will be already taken
            if self.fullNameTextField.text! == "David Patterson" {
                completion(result: true)
            } else {
                completion(result: false)
            }
        })
    }
    
    func hideKeyboard(){
        self.view.endEditing(true)
    }

    // MARK: ValidationDelegate Methods
    
    func validationSuccessful() {
        print("Validation Success!")
        let alert = UIAlertController(title: "Success", message: "You are validated, \(fullNameTextField.text!)!", preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    
    func validationFailed(errors:[UITextField:ValidationError]) {
        print("Validation FAILED!", validator.errors.count)
    }
    
    func remoteValidationRequest(text: String, urlString: String, completion: (result: Bool) -> Void) {
        simulateRemoteRequest(2) { result -> Void in
            // Set result to true if field was validated server-side
            // Set to false if field was not validated server-side
            completion(result: result)
        }
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
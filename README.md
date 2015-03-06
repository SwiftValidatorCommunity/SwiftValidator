Swift-Validator
===============

Swift Validator is a rule-based validation library for Swift.

![Swift Validator](https://dl.dropboxusercontent.com/u/18055521/swift-validator.gif)

## Core Concepts

* ``UITextField`` + ``ValidationRule`` go into  ```Validator``
* ``ITextField`` + ``ValidationError`` come out of ```Validator``
* ``UITextField`` is registered to ``Validator``
* ``Validator`` evaluates ``ValidationRules`` sequentially and stops evaluating when a ``ValidationRule`` fails. 
* Keys are used to allow field registration in TableViewControllers and complex view hierarchies

## Quick Start

Initialize the ``Validator`` by setting a delegate to a View Controller or other object.

```swift

// ViewController.swift

let validator = Validator()

override func viewDidLoad() {
    super.viewDidLoad()
}

```

Register the fields that you want to validate

```swift

// Validation Rules are evaluated from left to right.
validator.registerField(fullNameTextField, rules: [RequiredRule(), FullNameRule()])

// You can pass in error labels with your rules

validator.registerField(emailTextField, errorLabel: emailErrorLabel, rules: [RequiredRule(), EmailRule()])

// You can validate against other fields
validator.registerField(emailConfirmTextField, errorLabel: emailConfirmErrorLabel, rules: [RequiredRule(), EmailRule(), ConfirmationRule(confirmField: emailTextField)])

// You can now pass in regex and length parameters through  overloaded contructors
validator.registerField(phoneNumberTextField, errorLabel: phoneNumberErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 9)])
validator.registerField(zipcodeTextField, errorLabel: zipcodeErrorLabel, rules: [RequiredRule(), ZipCodeRule()])

```


Validate All Fields

```swift

validator.validateAllKeys(delegate:self)

// ValidationDelegate methods

func validationWasSuccessful() {
	// submit the form
}

func validationFailed(errors:[String:ValidationError]){
	// turn the fields to red
	for error in errors.values {
		error.textField.backgroundColor = UIColor.redColor()
		println("error -> \(error.error.description)")
	}
}

```

## Custom Validation 

We will create a ```SSNValidation``` class to show how to create your own Validation. A United States Social Security Number (or SSN) is a field that consists of XXX-XX-XXXX. 

Create a class that implements the Validation protocol

```swift

class SSNValidation: Validation {
    let SSN_REGEX = "^\\d{3}-\\d{2}-\\d{4}$"
    
    func validate(value: String) -> (Bool, ValidationErrorType) {
        if let ssnTest = NSPredicate(format: "SELF MATCHES %@", SSN_REGEX) {
            if ssnTest.evaluateWithObject(value) {
                return (true, .NoError)
            }
            return (false, .SocialSecurity) // We will create this later ValidationErrorType.SocialSecurity
        }
        return (false, .SocialSecurity)
    }
    
}

Credits
-------

Swift Validator is written and maintained by Jeff Potter [@jpotts18](http://twitter.com/jpotts18) and friends.

## Contributing

1. [Fork it](https://github.com/jpotts18/swift-validator/fork)
2. Create your feature branch `git checkout -b my-new-feature`
3. Commit your changes `git commit -am 'Add some feature'`
4. Push to the branch `git push origin my-new-feature`
5. Create a new Pull Request

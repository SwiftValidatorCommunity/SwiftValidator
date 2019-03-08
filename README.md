SwiftValidator
===============

[![Build Status](https://travis-ci.org/SwiftValidatorCommunity/SwiftValidator.svg?branch=master)](https://travis-ci.org/SwiftValidatorCommunity/SwiftValidator) [![codecov.io](https://codecov.io/github/SwiftValidatorCommunity/SwiftValidator/coverage.svg?branch=master)](https://codecov.io/github/SwiftValidatorCommunity/SwiftValidator?branch=master)

Swift Validator is a rule-based validation library for Swift.

![Swift Validator](/swift-validator-v2.gif)

## Core Concepts

* ``UITextField`` + ``[Rule]`` + (and optional error ``UILabel``) go into  ``Validator``
* ``UITextField`` + ``ValidationError`` come out of ``Validator``
* ``Validator`` evaluates ``[Rule]`` sequentially and stops evaluating when a ``Rule`` fails. 

## Installation

```ruby
# Podfile
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, "8.1"

use_frameworks!

# Swift 3
# Extended beyond UITextField
pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git', :branch => 'master'

# Swift 2.1
# Extended beyond UITextField
# Note: Installing 4.x.x will break code from 3.x.x
pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git', :tag => '4.0.0'

# Swift 2.1 (limited to UITextField validation)
pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git', :tag => '3.0.5'
```

Install into your project:

```bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file):

```bash
$ open MyProject.xcworkspace
```

If you are using Carthage you will need to add this to your `Cartfile`

```bash
github "jpotts18/SwiftValidator"
```

## Usage 

You can now import SwiftValidator framework into your files.

Initialize the ``Validator`` by setting a delegate to a View Controller or other object.

```swift
// ViewController.swift
let validator = Validator()
```

Register the fields that you want to validate

```swift
override func viewDidLoad() {
	super.viewDidLoad()

	// Validation Rules are evaluated from left to right.
	validator.registerField(fullNameTextField, rules: [RequiredRule(), FullNameRule()])
	
	// You can pass in error labels with your rules
	// You can pass in custom error messages to regex rules (such as ZipCodeRule and EmailRule)
	validator.registerField(emailTextField, errorLabel: emailErrorLabel, rules: [RequiredRule(), EmailRule(message: "Invalid email")])
	
	// You can validate against other fields using ConfirmRule
	validator.registerField(emailConfirmTextField, errorLabel: emailConfirmErrorLabel, rules: [ConfirmationRule(confirmField: emailTextField)])
	
	// You can now pass in regex and length parameters through overloaded contructors
	validator.registerField(phoneNumberTextField, errorLabel: phoneNumberErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 9)])
	validator.registerField(zipcodeTextField, errorLabel: zipcodeErrorLabel, rules: [RequiredRule(), ZipCodeRule(regex : "\\d{5}")])

	// You can unregister a text field if you no longer want to validate it
	validator.unregisterField(fullNameTextField)
}
```


Validate Fields on button tap or however you would like to trigger it. 

```swift
@IBAction func signupTapped(sender: AnyObject) {
	validator.validate(self)
}
```

Implement the Validation Delegate in your View controller

```swift
// ValidationDelegate methods

func validationSuccessful() {
	// submit the form
}

func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
  // turn the fields to red
  for (field, error) in errors {
    if let field = field as? UITextField {
      field.layer.borderColor = UIColor.red.cgColor
      field.layer.borderWidth = 1.0
    }
    error.errorLabel?.text = error.errorMessage // works if you added labels
    error.errorLabel?.isHidden = false
  }
}

```

## Single Field Validation

You may use single field validation in some cases. This could be useful in situations such as controlling responders:

```swift
// Don't forget to use UITextFieldDelegate
// and delegate yourTextField to self in viewDidLoad()
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
```

## Custom Validation 

We will create a ```SSNRule``` class to show how to create your own Validation. A United States Social Security Number (or SSN) is a field that consists of XXX-XX-XXXX. 

Create a class that inherits from RegexRule

```swift

class SSNVRule: RegexRule {

    static let regex = "^\\d{3}-\\d{2}-\\d{4}$"
	
    convenience init(message : String = "Not a valid SSN"){
	self.init(regex: SSNVRule.regex, message : message)
    }
}
```

## Documentation
Checkout the docs <a href="http://swiftvalidatorcommunity.github.io/SwiftValidator/">here</a> via [@jazzydocs](https://twitter.com/jazzydocs).


Credits
-------

Swift Validator is written and maintained by Jeff Potter [@jpotts18](http://twitter.com/jpotts18). David Patterson [@dave_tw12](http://twitter.com/dave_tw12) actively works as a collaborator. Special thanks to [Deniz Adalar](https://github.com/dadalar) for
adding validation beyond UITextField.

## Contributing

1. [Fork it](https://github.com/jpotts18/SwiftValidator/fork)
2. Create your feature branch `git checkout -b my-new-feature`
3. Commit your changes `git commit -am 'Add some feature'`
4. Push to the branch `git push origin my-new-feature`
5. Create a new Pull Request
6. Make sure code coverage is at least 70%

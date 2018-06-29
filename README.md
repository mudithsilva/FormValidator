# FormValidator
Simple SWIFT library for Name, Email, Password and Digit Validation

- [Features](#features)
- [Name Validation Options](#name-validation-options)
- [Password Validation Options](#password-validation-options)
- [Installation](#installation)
- [Usage](#usage)
- [TextField Types](#textFieldTypes)

## Features

- [x] Name Validation.
- [x] Email Validation.
- [x] Customizable Password Options.
- [x] Detect Digit Value.
- [x] Text Validation without extra spaces.

## Name Validation Options

- [x] Shows error -  front and back extra spaces. eg:- "  Andrew", "Andrew  ", "James Andrew   ", "  James Andrew   "
- [x] Shows error -  Digits in the name text. eg:- "Andrew12", "Andre1w"
- [x] Shows error -  Extra spaces with two name (More than one space). eg:- "James   Andrew", "James    Andrew"
- [x] Shows error -  If name field is empty.

## Password Validation Options

- [x] Minimum 8 characters at least 1 Alphabet and 1 Number
- [x] Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character
- [x] Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number
- [x] Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character
- [x] Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character:
- [x] Any 8 characters

## Installation

Simply copy and paste FormValidator File on your Project :)

## Usage

#### Step 01

First you need to create FormField Objects in order to pass FormField Array to FormValidator Class.

```
    let userEmailForm = FormField(text: self.userEmail.text!, fieldType: .email, fieldName: "Email Address")
    let userPasswordForm = FormField(text: self.userEmail.text!, fieldType: .password, fieldName: "Password")

```

#### Step 02

Then you can Pass Field data Array to FormValidator Class.

```
    FormValidator.checkFieldsValidity(fields: [userEmailForm, userPasswordForm]) { (msg) in
        if msg.valid {
            print("Correct Data")
        } else {
            print(msg.errorMsg!)
        }
    }

```

## TextField Types

```
    case text 
    case name
    case email
    case digit
    case password
    
 ```


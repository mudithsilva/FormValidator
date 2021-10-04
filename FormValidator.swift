//
//  FormValidator.swift
//  FieldValidationLib
//
//  Created by Mudith Chathuranga on 3/19/18.
//  Copyright © 2018 Chathuranga. All rights reserved.
//

import Foundation
import UIKit


struct FormValidator {
    
    static func checkFieldsValidity(fields: [FormField], completion: (ValidationMessage) -> ()) {
        let msg = ValidationMessage()
        
        for index in stride(from: 0, to: fields.count, by: 1) {
            let trimmedData = fields[index].text.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if trimmedData == "" {
                msg.valid = false
                msg.errorMsg = "Please enter " + fields[index].fieldName
                break
            } else {
                let regEx = fields[index].fieldType.rawValue
                let regExTest = NSPredicate(format:"SELF MATCHES %@", regEx)
                msg.valid = regExTest.evaluate(with: fields[index].text)
                
                if msg.valid == true {
                    msg.errorMsg = nil
                } else {
                    msg.errorMsg = getErrorMsg(fieldType: fields[index].fieldType, fieldName: fields[index].fieldName)
                    break
                }
            }
        }
        completion(msg)
    }
    
    static func isValidFieldInput(input:String, fieldType: TextFieldTypes) -> Bool {
        let regEx = fieldType.rawValue
        let regExTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return regExTest.evaluate(with: input)
    }
    
    
    static func getErrorMsg(fieldType: TextFieldTypes, fieldName: String) -> String {
        let commonMsg = "Please enter a valid"
        switch fieldType {
        case TextFieldTypes.text: return "\(commonMsg) \"\(self.getBoldText(text: fieldName))\" \n\n\(self.centerText(text: "Hint:")) \n Remove extra blank spaces. "
        case TextFieldTypes.name: return "\(commonMsg) \"\(self.getBoldText(text: fieldName))\" \n\n\(self.centerText(text: "Hint:")) \n Use alphabetical characters only. \n Remove extra blank spaces. "
        case TextFieldTypes.email: return "\(commonMsg) \"\(self.getBoldText(text: fieldName))\""
        case TextFieldTypes.digit: return "\(commonMsg) \"\(self.getBoldText(text: fieldName))\" \n\(self.centerText(text: "Hint:")) \n Phone number should include 10 digits."
        case TextFieldTypes.password : return "\(commonMsg) \"\(self.getBoldText(text: fieldName))\" \n\(self.centerText(text: "Hint:")) \n Password should include 4 - 20 characters. \n Password should not contain any white spaces."
        }
    }
    
    static func getBoldText(text: String) -> String {
        let messageText = NSMutableAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15.0),
                //NSForegroundColorAttributeName : UIColor.blackColor()
            ]
        )
        return messageText.string
    }
    
    static func centerText(text: String) -> String {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let messageText = NSMutableAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle
                //NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody),
                //NSForegroundColorAttributeName : UIColor.blackColor()
            ]
        )
        return messageText.string
    }

}

/////////////////////////////////// Class FormField  ///////////////////////////////////
class FormField: NSObject {
    
    var text: String!
    var fieldType: TextFieldTypes!
    var fieldName: String!
    
    init(text: String, fieldType: TextFieldTypes, fieldName: String) {
        self.text = text
        self.fieldType = fieldType
        self.fieldName = fieldName
    }
    
}

/////////////////////////////////// Class FormField  ///////////////////////////////////

/////////////////////////////////// Class ValidationMessage  ///////////////////////////////////
class ValidationMessage: NSObject {
    
    var valid: Bool! = true
    var errorMsg: String? = nil
    
}

/////////////////////////////////// Class ValidationMessage  ///////////////////////////////////

/////////////////////////////////// TextFiled Types Enum  ///////////////////////////////////

enum TextFieldTypes: String {
    case text = "^[^ ]+( [^ ]+)*$"
    case name = "^[^ ][a-zA-Z]{0,}+( [^ ][a-zA-Z]*)*$"  //^[^ ][a-zA-Z]+( [^ ][a-zA-Z]*)*$
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    case digit = "^[0-9]*$"
    case password =  "^[a-zA-Z0-9~!@#$%^&*(){}=?><:;'\"+-_]{4,20}$" //"^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
}

//Password Validators
//
//^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$   - Minimum 8 characters at least 1 Alphabet and 1 Number
//
//^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$   - Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character
//
//^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$  - Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number
//
//^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}   - Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character:
//
//^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,10}  - Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character:
//^[a-zA-Z0-9~!@#$%^&*(){}=?><:;'"+-_]{8,20}$  -  Any 8characters

//Email Validators
// [A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}   - email validator


//Other Validators
//^[^ ][a-zA-Z]+( [^ ][a-zA-Z]*)*$   - Name
// ^[a-zA-Z\s]+$   - All letters including white spaces
// [\S]+$  - Trailing Spaces
// ^[\S] -  Starting Space

/////////////////////////////////// TextFiled Types Enum  ///////////////////////////////////

//
//  ViewController.swift
//  SimpleForm
//
//  Created by Akanksha pakhale on 25/10/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    //MARK:All the outlets from storyboard
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var fatherNameTxtField:UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    
    @IBOutlet weak var mobileNumberTxtField: UITextField!
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var nameAlertLbl: UILabel!
    @IBOutlet weak var FatherNameAlertLbl: UILabel!
    @IBOutlet weak var AddressAlertLbl: UILabel!
    
    @IBOutlet weak var mobileNumberAlertLbl: UILabel!
    
    @IBOutlet weak var emailAlertLbl: UILabel!
    
    @IBOutlet weak var passwordAlert: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting up textfield UI
        setUIForTextField(tf: nameTxtField, delegate: self)
        setUIForTextField(tf: fatherNameTxtField, delegate: self)
        setUIForTextField(tf: addressTxtField, delegate: self)
        setUIForTextField(tf: mobileNumberTxtField, delegate: self)
        setUIForTextField(tf: emailTxtField, delegate: self)
        setUIForTextField(tf: passwordTxtField, delegate: self)
        //Array of all alert labels
        valid = [nameAlertLbl,FatherNameAlertLbl,passwordAlert,emailAlertLbl,mobileNumberAlertLbl,AddressAlertLbl]
        // hideKeyboardWhenTappedAround on screen calling function
        hideKeyboardWhenTappedAround()
    }
    //MARK:Function for UI of textField
    func setUIForTextField(tf: UITextField,delegate:UITextFieldDelegate){
            tf.layer.borderColor = UIColor(red: 214.0/255.0, green: 129.0/255.0, blue: 174.0/255.0, alpha: 1).cgColor
            tf.layer.borderWidth = 3
       tf.delegate = delegate
        }
    //MARK:Function for enter button in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
   //MARK:Action on submit Button
    @IBAction func submitInfo(_ sender: Any) {
        var register = true
        //Checking all Alert labels
        for l in valid{
            if !l.isHidden{
               register = false
                l.text = "this is mendotory field "
            }
        }
        //no Alert labels then save user data
        if register{
            // save our data
            var userDic:[String:String] = [:]
            userDic.updateValue(nameTxtField.text!, forKey: "name")
            userDic.updateValue(fatherNameTxtField.text!, forKey: "father")
            userDic.updateValue(addressTxtField.text!, forKey: "address")
            userDic.updateValue(emailTxtField.text!, forKey: "email")
            userDic.updateValue(mobileNumberTxtField.text!, forKey: "number")
            userDic.updateValue(passwordTxtField.text!, forKey: "pwd")
            UserDefaults.standard.set(userDic, forKey: "userData")
            // show alert for Succesful Register
            let alert = UIAlertController(title: "Register successfully", message: "You are successfully register now you can Login", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
        }
        //show alert for fields mandatory
        else {
            let alert = UIAlertController(title: "Warning", message: "All fields are mandatory.", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
        }
    }
    //MARK:navigates to login page on login Btn clicked
    @IBAction func loginPage(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    var valid:[UILabel]=[]
    //MARK:Vaditating textField on keyboard action
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTxtField:
            checkTextField(textField: nameTxtField, alrtLbl: nameAlertLbl, incorrectMsg: "Enter Correct name", EmptyMsg: "Name field should not be Empty", selector: isValidname(_:))
        case fatherNameTxtField:
            checkTextField(textField: fatherNameTxtField, alrtLbl: FatherNameAlertLbl, incorrectMsg: "Enter Correct name", EmptyMsg: "Name field should not be Empty", selector: isValidname(_:))

        case emailTxtField:
            checkTextField(textField: emailTxtField, alrtLbl: emailAlertLbl, incorrectMsg: "Enter Correct Email", EmptyMsg: "Email field should not be Empty", selector: isValidEmail(_:))
            
        case mobileNumberTxtField:
            checkTextField(textField: mobileNumberTxtField, alrtLbl: mobileNumberAlertLbl, incorrectMsg: "Enter Correct phone number", EmptyMsg: "phone number should not be Empty", selector: isValidphoneNumber(_:))
            
        case passwordTxtField:
            checkTextField(textField: passwordTxtField, alrtLbl: passwordAlert, incorrectMsg: "Enter password with atleast 1 Aphabet 1 numeric and minium lenght of 8 Character", EmptyMsg: "phone number should not be Empty", selector: isValidpassword(_:))
        default:
            ()
         }
    }
    //MARK:Validation function
    typealias MethodsHandler = (String) -> Bool
    func checkTextField(textField: UITextField, alrtLbl: UILabel, incorrectMsg: String, EmptyMsg: String , selector: (String) -> Bool){
        if textField.text != nil && !textField.text!.isEmpty {
            if selector(textField.text!) {
                alrtLbl.isHidden = true
            }
            else {
                alrtLbl.text = incorrectMsg
                alrtLbl.isHidden = false
            }
          }
        else{
            alrtLbl.text = EmptyMsg
            alrtLbl.isHidden = false
        }
    }
    //MARK:Regex for valid name
    func isValidname(_ name: String) -> Bool {
        let nameRegEx = "^[a-zA-Z ]{3,30}$"//".*[^A-Za-z ].*"
        
        let nameTest = NSPredicate(format:"SELF MATCHES[c] %@", nameRegEx)
        
        return nameTest.evaluate(with: name)
    }
    //MARK: Function for password validation

    // Minimum 8 characters at least 1 Alphabet and 1 Number:

     func isValidpassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let passwordTest = NSPredicate(format:"SELF MATCHES[c] %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    //MARK: Function for email validation
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    //MARK: Function for phone number validation
        
        func isValidphoneNumber(_ phoneNumber: String) -> Bool {
            let phoneNumberRegEx = "^[6-9][0-9]{9}$"
            let phoneNumberTest = NSPredicate(format:"SELF MATCHES[c] %@", phoneNumberRegEx)
            return phoneNumberTest.evaluate(with: phoneNumber)
        }
    }
//MARK:Hiding keyboard func when tap on screen
    extension UIViewController {
        func hideKeyboardWhenTappedAround() {
            let tapGesture = UITapGestureRecognizer(target: self,
                             action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapGesture)
        }

        @objc func hideKeyboard() {
            
            view.endEditing(true)
        }
    }



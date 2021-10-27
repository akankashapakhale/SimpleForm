//
//  LoginViewController.swift
//  SimpleForm
//
//  Created by Akanksha pakhale on 25/10/21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK:All outslets from storyboard
    @IBOutlet weak var emailTxtF: UITextField!
    @IBOutlet weak var paswardTXTF: UITextField!
    @IBOutlet weak var pwdAlertLbl: UILabel!
    @IBOutlet weak var emailAlertLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigation bar items
        self.navigationItem.title = "Log In"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = " "
        //setting up UI for textfields
        setUIForTextField(tf: emailTxtF, delegate: self)
        setUIForTextField(tf: paswardTXTF, delegate: self)
        hideKeyboardd()
    }
    //MARK:Function for textField UI
    func setUIForTextField(tf: UITextField,delegate:UITextFieldDelegate){
            tf.layer.borderColor = UIColor(red: 214.0/255.0, green: 129.0/255.0, blue: 174.0/255.0, alpha: 1).cgColor
            tf.layer.borderWidth = 3
       tf.delegate = delegate
        }
    //MARK:Function for login User
    @IBAction func loginUser(_ sender: Any) {
        //checking textfield empty
        if emailTxtF.text != nil || paswardTXTF.text != nil{
            //setting data
            let data =  UserDefaults.standard.value(forKey: "userData") as? [String:String]
            //matching data
            if emailTxtF.text! == data!["email"] && paswardTXTF.text! == data!["pwd"]{
                let story = UIStoryboard(name: "Main", bundle: nil)
                //if matching push to details view
                let controller = story.instantiateViewController(identifier: "ListViewController") as! ListViewController
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(controller, animated: true)
                }
           }else{
            //not matched data showing alert
                let alert = UIAlertController(title: "Error", message: "ID and password does not match", preferredStyle: UIAlertController.Style.alert)

                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        // show the alert
                        self.present(alert, animated: true, completion: nil)
            }
        }else{
            //show alert for field entery
            let alert = UIAlertController(title: "Warning", message: "This is mandatory fields", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
        }
      
    }
    //MARK:Function for back to registration page when registration button clicked
    @IBAction func goToRegistrationPage(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(identifier: "ViewController") as! ViewController
         //self.present(controller, animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK:Hiding keyboard func when tap on screen
extension UIViewController {
    func hideKeyboardWhenTappedAroundd() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboardd() {
        
        view.endEditing(true)
    }
}

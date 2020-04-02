//
//  UserManagerViewController.swift
//  Car Inventory
//
//  Created by Arthur Ataide on 2020-03-28.
//  Copyright © 2020 Arthur Ataide. All rights reserved.
//

import UIKit

class UserManagerViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var userTypeSegmentedControl: UISegmentedControl!
    
    var databaseManager:DatabaseManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        databaseManager = DatabaseManager.getInstance()
    }

    @IBAction func saveBtnPressed(_ sender: UIButton) {
        
        var checkMessage = checkRequiredFields()
        
        if checkMessage == "" {
        //Set entity
        var save = true
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        databaseManager?.setEntityName("UserEntity")
        
        //Checking if email already exists
        for obj in (databaseManager?.toList())! {
            let user = obj as! User
            if user.email == email{
                save = false
                break
            }
        }
        
        if save {
            //Creating user
            var user = User()
            user.email = email
            user.name = nameTextField.text
            user.password = passwordTextField.text
            
            user.accountType = userTypeSegmentedControl.selectedSegmentIndex == 0 ? 1 : 2
            //Adding row
            databaseManager?.addRow(user as AnyObject)
            showMessage("User", "User created.", "OK")
            
            nameTextField.text = ""
            emailTextField.text = ""
            passwordTextField.text = ""
            confirmPasswordTextField.text = ""
            
        }else{
            showMessage("User", "Email already exists.", "OK")
        }
        }else{
            showMessage("User", checkMessage, "OK")
        }
    }
    
    func checkRequiredFields() -> String{
        var message:String = ""
        
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {message = "Complete all required fields"}
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {message = "Complete all required fields"}
        if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {message = "Complete all required fields"}
        if confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {message = "Complete all required fields"}
        if passwordTextField.text != confirmPasswordTextField.text {message = "Password fields are not matching"}
        if !emailTextField.text!.contains("@") || !emailTextField.text!.contains(".") {message = "Email does not have a valid format"}
        print(emailTextField.text)
        return message
    }
    
    func showMessage(_ title:String, _ message:String, _ actionMessage:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString(actionMessage, comment: actionMessage), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.endEditing(true)
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        confirmPasswordTextField.endEditing(true)
    }
}

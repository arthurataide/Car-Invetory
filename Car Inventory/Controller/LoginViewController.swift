//
//  LoginViewController.swift
//  Car Inventory
//
//  Created by Arthur Ataide on 2020-03-28.
//  Copyright © 2020 Arthur Ataide. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*Inserting dummy data for testing*/
        let sample = Sample()
        sample.insertDummyData()
        /******************************/
        
        emailTextField.text = "vendor@car.com"
        passwordTextField.text = "1234"
        
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginBtnPressed(_ sender: UIButton) {
        let databaseManager = DatabaseManager.getInstance()
        databaseManager.setEntityName("UserEntity")
        
        let email = emailTextField.text
        let password = passwordTextField.text
        var loginOk = false
        
        
        for userObject in databaseManager.toList(){
            user = userObject as? User
            
            if email == user?.email && password == user?.password{
                loginOk = true
                break //breaing loop
            }
        }
        
        if loginOk{
            if user?.accountType == 1{
                //Vendor
                performSegue(withIdentifier: K.Segues.loginUserCars, sender: self)
            }else if(user?.accountType == 2){
                //Manager
                performSegue(withIdentifier: K.Segues.loginManagerPage, sender: self)
            }
        }else{
            showAlert()
        }
        
    }
    @IBAction func manageBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.loginManagerPage, sender: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    func showAlert() -> Void {
        
        let alert = UIAlertController(title: "Authentication", message: "Wrong email or password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .default))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let segueName = segue.identifier
        
        if segueName == K.Segues.loginManagerPage{
           let destinationVC = segue.destination as! ManagerMenuViewController
           destinationVC.user = user
        }
        
    }
    
}

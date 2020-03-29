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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.loginUserCars, sender: self)
    }
    @IBAction func manageBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.loginManagerPage, sender: self)
    }
}

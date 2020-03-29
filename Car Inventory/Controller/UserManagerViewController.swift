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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveBtnPressed(_ sender: UIButton) {
        
    }
}

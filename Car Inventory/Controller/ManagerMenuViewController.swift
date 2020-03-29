//
//  ManagerMenuViewController.swift
//  Car Inventory
//
//  Created by Arthur Ataide on 2020-03-28.
//  Copyright © 2020 Arthur Ataide. All rights reserved.
//

import UIKit

class ManagerMenuViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        title = "Manager Menu"
        
    }
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
         navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func carListBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.menuToCarsAdministration, sender: self)
    }
    
    @IBAction func userManagerPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.menuUserManager, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.menuToCarsAdministration
        {
            let destinationVC = segue.destination as! CarsViewController
            destinationVC.segueName = segue.identifier
        }
    }
    
    
}

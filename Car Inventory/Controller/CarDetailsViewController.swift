//
//  CarDetailsViewController.swift
//  Car Inventory
//
//  Created by Arthur Ataide on 2020-03-28.
//  Copyright © 2020 Arthur Ataide. All rights reserved.
//

import UIKit

class CarDetailsViewController: UIViewController {
    
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var vinLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var segueName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if segueName != K.Segues.menuToCarsAdministration {
            deleteBtn.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteBtnPressed(_ sender: UIButton) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  CarsTableViewCell.swift
//  Car Inventory
//
//  Created by Arthur Ataide on 2020-03-29.
//  Copyright © 2020 Arthur Ataide. All rights reserved.
//

import UIKit

class CarsTableViewCell: UITableViewCell {

    @IBOutlet weak var carCustomCells: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        if selected {
            carCustomCells.backgroundColor = #colorLiteral(red: 0, green: 0.714643538, blue: 0.8382397294, alpha: 1)
        }
    }
    
}

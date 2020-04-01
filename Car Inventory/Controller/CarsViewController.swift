//
//  CarsViewController.swift
//  Car Inventory
//
//  Created by Arthur Ataide on 2020-03-28.
//  Copyright © 2020 Arthur Ataide. All rights reserved.
//

import UIKit

class CarsViewController: UIViewController {
    
    var segueName: String?
    var cars: [Car] = []
    var index:Int?
    
    @IBOutlet weak var createCarsBtn: UIBarButtonItem!
    @IBOutlet weak var carsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationTab Settings
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        title = "Cars"
        if segueName != K.Segues.menuToCarsAdministration {
            self.navigationItem.leftBarButtonItem = nil
        }
        
        
        //Custom Cell resgistration
        
        carsTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        //carsTableView.rowHeight = 160
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func logOutBtnPressed(_ sender: UIBarButtonItem) {
         navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func createButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /*Getting list of cars*/
        DatabaseManager.getInstance().setEntityName("CarEntity")
        cars = DatabaseManager.getInstance().toList() as! [Car]
        /************/
        
        carsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != K.Segues.carsToAdd {
            
            let destinationVC = segue.destination as! CarDetailsViewController
            segueName = segue.identifier
            
            if segueName == K.Segues.menuToCarsAdministration{
                destinationVC.segueName = segueName
                
            } else if segueName == K.Segues.carsToDetails{
                destinationVC.segueName = segueName
                destinationVC.car = cars[index!]
            }
        }
    }
}

extension CarsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! CarsTableViewCell
        
        cell.carNameLabel.text = cars[indexPath.row].name
        cell.modelLabel.text = cars[indexPath.row].model
        cell.priceLabel.text = String(cars[indexPath.row].price ?? 0)
        cell.carImageView.image = UIImage(named: cars[indexPath.row].image ?? "no_photo")
        
        return cell
    }
    
}

extension CarsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        print("K.Segues.carsToDetails \(K.Segues.carsToDetails)")
        performSegue(withIdentifier: K.Segues.carsToDetails, sender: self)
    }
    
}
	

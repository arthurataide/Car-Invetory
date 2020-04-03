//
//  AddCarViewController.swift
//  Car Inventory
//
//  Created by Arthur Ataide on 2020-03-28.
//  Copyright © 2020 Arthur Ataide. All rights reserved.
//

import UIKit

class AddCarViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var vinTextField: UITextField!
    @IBOutlet weak var colorTextFIeld: UITextField!
    @IBOutlet weak var modelPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var priceTextField: UITextField!
    
    var models = ["Honda Civic","Toyota Corolla", "Hyunday Elantra",
                  "Honda CRV", "Toyota Camry", "Jeep Grand Cherokee",
                    "Honda Fit","Mazda Demio","Toyta Vitz"]
    
    var years:[String] = []
    
    var imagePicker = UIImagePickerController()
    
    var databaseManager:DatabaseManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Cars"
        scrollView.isScrollEnabled = true
        scrollView.contentSize = view.frame.size
        
        modelPicker.tag = 1
        yearPicker.tag = 2
        
        modelPicker.dataSource = self
        modelPicker.delegate = self
        yearPicker.dataSource = self
        yearPicker.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.imageTap(_:)))
        carImageView.addGestureRecognizer(tap)
        carImageView.isUserInteractionEnabled = true
        
        //addTarget(self, action: #selector(self.tapBlurButton(_:)), forControlEvents: .TouchUpInside)
        
        //Filling years
        for y in 2009 ... 2022{
            let year = String(y)
            years.append(year)
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        
        if nameTextField.text != "" && vinTextField.text != "" && priceTextField.text != "" && colorTextFIeld.text != "" {
            
            databaseManager = DatabaseManager.getInstance()
            databaseManager?.setEntityName("CarEntity")
            let year =  Int(years[modelPicker.selectedRow(inComponent: 0)])
            let price = Float(priceTextField.text!)
            
            var car = Car()
            car.name = nameTextField.text
            car.vin = vinTextField.text
            car.model = models[modelPicker.selectedRow(inComponent: 0)]
            car.year = year
            car.image = "no_photo"
            car.price = price
            car.color = colorTextFIeld.text
            databaseManager?.addRow(car as AnyObject)
         
            vinTextField.text = ""
            nameTextField.text = ""
            priceTextField.text = ""
            colorTextFIeld.text = ""
            
            showMessage("Car", "Car created successfully.", "OK")
        }else{
            showMessage("Car", "Plese complete all required fields.", "OK")
        }
        
    }
    
    @objc func imageTap(_ sender: UITapGestureRecognizer? = nil) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func showMessage(_ title:String, _ message:String, _ actionMessage:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString(actionMessage, comment: actionMessage), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        vinTextField.endEditing(true)
        nameTextField.endEditing(true)
        priceTextField.endEditing(true)
        colorTextFIeld.endEditing(true)
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

extension AddCarViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        if pickerView.tag == 1{
            count = models.count
        }else{
            count = years.count
        }

        return count
    }

}

extension AddCarViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var title = ""
        if pickerView.tag == 1{
            title = models[row]
        }else{
            title = years[row]
        }

        return title
    }
}

extension AddCarViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        carImageView.contentMode = .scaleAspectFit
        carImageView.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    
}

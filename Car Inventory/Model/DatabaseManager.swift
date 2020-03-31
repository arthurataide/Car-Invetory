//
//  DatabaseManager.swift
//  Car Inventory
//
//  Created by user163027 on 3/28/20.
//  Copyright © 2020 Jose Smith Marmolejos. All rights reserved.
//


import UIKit
import CoreData

public class DatabaseManager{
    private static var databaseManager:DatabaseManager?
    private var appDelegate:AppDelegate?
    private var managedContext:NSManagedObjectContext?
    private var entity:NSEntityDescription?
    private var objects:[NSManagedObject] = []
    private var entityName:String?
    private var _selected:Int?
    
    private init() {
        
        if UIApplication.shared.delegate != nil{
            appDelegate = UIApplication.shared.delegate as? AppDelegate
            managedContext = appDelegate?.persistentContainer.viewContext
            
            fetch()
        }
    }
    
    public static func getInstance() -> DatabaseManager{
        
        if (databaseManager == nil){
            databaseManager = DatabaseManager()
        }
        return databaseManager!
    }
    
    func setEntityName(_ entityName:String){
        self.entityName = entityName
        fetch()
    }
    
    func getEntityName() ->String{
        return self.entityName ?? ""
    }
    
    func addRow(_ data:AnyObject){
        var rowAdded = false
        entity = NSEntityDescription.entity(forEntityName: self.entityName!, in: managedContext!)
        let object = NSManagedObject(entity: entity!, insertInto: managedContext!)
        
        if managedContext != nil{
            if let eName = entityName{
                if eName == "User_type_Entity"{
                    
                    let d = data as? UserType
                    object.setValue(d?.id, forKey: "user_type_id")
                    object.setValue(d?.name, forKey: "user_type_name")
                    rowAdded = true
                    
                }
                
                if eName == "UserEntity"{
                    //TODO: Add code
                    let d = data as! User
                    object.setValue(d.email, forKey: "user_email")
                    object.setValue(d.name, forKey: "user_name")
                    object.setValue(d.accountType, forKey: "user_type_account")
                    object.setValue(d.password, forKey: "user_password")
                    
                    rowAdded = true
                }
                
                if eName == "CarEntity"{
                    //TODO: Add code
                    let d = data as! Car
                    object.setValue(d.vin, forKey: "car_vin")
                    object.setValue(d.name, forKey: "car_name")
                    object.setValue(d.color, forKey: "car_color")
                    object.setValue(d.model, forKey: "car_model")
                    object.setValue(d.price, forKey: "car_price")
                    object.setValue(d.year, forKey: "car_year")
                    object.setValue(d.image, forKey: "car_image")
                    
                    rowAdded = true
                }
                
            }
        }
        
        if rowAdded{
            do{
                try managedContext?.save()
                objects.append(object)
                print("New row added")
            }catch let error as NSError{
                print("Could not save data. \(error), \(error.userInfo)")
            }
        }
    }
    
    func fetch(){
        
        if entityName != nil && managedContext != nil{
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName!)
            do{
                objects = try (managedContext?.fetch(fetchRequest))!
            }catch let error as NSError{
                print("Could not fetch data. \(error), \(error.userInfo)")
            }
        }
    }
    
    func toList()->[AnyObject]{
        
        var anyArray:[AnyObject] = []
        
        if let eName = entityName{
            
            if eName == "User_type_Entity"{
                
                for object in objects{
                    var d  = UserType()
                    
                    if let id = object.value(forKeyPath: "user_type_id") as? Int{
                        d.id = id
                    }
                    if let name = object.value(forKeyPath: "user_type_name") as? String{
                        d.name = name
                    }
                    
                    anyArray.append(d as AnyObject)
                }
            }
            
            if eName == "UserEntity"{
                for object in objects{
                    var d = User()
                    
                    if let email = object.value(forKeyPath: "user_email") as? String{
                        d.email = email
                    }
                    if let name = object.value(forKeyPath: "user_name") as? String{
                        d.name = name
                    }
                    if let accountType = object.value(forKeyPath: "user_type_account") as? Int{
                        d.accountType = accountType
                    }
                    if let password = object.value(forKeyPath: "user_password") as? String{
                        d.password = password
                    }
        
                    anyArray.append(d as AnyObject)
                }
            }
            if eName == "CarEntity"{
                //TODO: Add code
                for object in objects{
                    var d = Car()
                    if let vin = object.value(forKeyPath: "car_vin") as? String{
                        d.vin = vin
                    }
                    if let name = object.value(forKeyPath: "car_name") as? String{
                        d.name = name
                    }
                    if let color = object.value(forKeyPath: "car_color") as? String{
                        d.color = color
                    }
                    if let model = object.value(forKeyPath: "car_model") as? String{
                        d.model = model
                    }
                    if let price = object.value(forKeyPath: "car_price") as? Float{
                        d.price = price
                    }
                    if let year = object.value(forKeyPath: "car_year") as? Int{
                        d.year = year
                    }
                    if let image = object.value(forKeyPath: "car_image") as? String{
                        d.image = image
                    }
                    
                    anyArray.append(d as AnyObject)
                }
            }
            
        }
        return anyArray
    }
    
    func removeAll(){
        
        fetch()
        do {
            for object in objects {
                managedContext!.delete(object)
                try managedContext?.save()
            }
            objects = []
            print("All data deleted. \(entityName ?? "")")
        } catch let error {
            print("Detele all data in \(entityName ?? "") error :", error)
        }
    }
    
    func removeRowByIndex(index:Int){
        
        if objects.count > index{
            managedContext?.delete(objects[index])
            
            do{
                try managedContext?.save()
                objects.remove(at: index)
                
                print("row removed")
            }catch let error as NSError{
                print("Could not remove data. \(error), \(error.userInfo)")
            }
        }
    }
    
    
    func modifyRow(data: AnyObject, index:Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        if let eName = entityName{
            if eName == "User_type_Entity"{
                let d = data as! UserType
                objects[index].setValue(d.id, forKey: "user_type_id")
                objects[index].setValue(d.name, forKey: "user_type_name")
            }
            
            if eName == "UserEntity"{
                let d = data as! User
                objects[index].setValue(d.email, forKey: "user_email")
                objects[index].setValue(d.name, forKey: "user_name")
                objects[index].setValue(d.accountType, forKey: "user_type_account")
                objects[index].setValue(d.password, forKey: "user_password")
            }
            
            if eName == "CarEntity"{
                let d = data as! Car
                objects[index].setValue(d.vin, forKey: "car_vin")
                objects[index].setValue(d.name, forKey: "car_name")
                objects[index].setValue(d.color, forKey: "car_color")
                objects[index].setValue(d.model, forKey: "car_model")
                objects[index].setValue(d.price, forKey: "car_price")
                objects[index].setValue(d.year, forKey: "car_year")
                objects[index].setValue(d.image, forKey: "car_image")
            }
        }
        
        
        do{
            try managedContext.save()
            print("Row modified")
        }catch let error as NSError{
            print("Could not save data. \(error), \(error.userInfo)")
        }
        
    }
    
    func selectObject(index: Int){
        self._selected = index
    }
    
    func deselectOject(){
        self._selected = -1
    }
    
    func selected()->NSObject{
        let student = objects[_selected!]
        return student
    }
    
    func selectedIndex() -> Int{
        return self._selected!
    }
}


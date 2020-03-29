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
            }
        }
        
        if rowAdded{
            do{
                try managedContext?.save()
                objects.append(object)
                print("New record added")
            }catch let error as NSError{
                print("Could not save data. \(error), \(error.userInfo)")
            }
        }
    }
    
    func fetch(){
        
        if entityName != nil && managedContext != nil{
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName!)
            do{
                print("Before: \(objects.count)")
                objects = []
                print("After: \(objects.count)")
                objects = try (managedContext?.fetch(fetchRequest))!
                print("After fetch: \(objects.count)")
                //print("rows \(objects)")
            }catch let error as NSError{
                print("Could not fetch data. \(error), \(error.userInfo)")
            }
        }
    }
    
    func toList()->[AnyObject]{
        
        var anyArray:[AnyObject] = []
        
        if let eName = entityName{
            print(eName)
            
            if eName == "User_type_Entity"{
                
                for obj in objects{
                    var model  = UserType()
                    
                    if let id = obj.value(forKeyPath: "user_type_id") as? Int{
                        model.id = id
                    }
                    if let name = obj.value(forKeyPath: "user_type_name") as? String{
                        model.name = name
                    }
                    
                    anyArray.append(model as AnyObject)
                    
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
    
    func modifyRow(data: AnyObject){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext

        
            if let eName = entityName{
                if eName == "User_type_Entity"{
                    let d = data as! UserType
                    objects[self._selected!].setValue(d.id, forKey: "user_type_id")
                    objects[self._selected!].setValue(d.name, forKey: "user_type_name")
                }
            }
        


        do{
            try managedContext.save()
            print("Record modified")
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


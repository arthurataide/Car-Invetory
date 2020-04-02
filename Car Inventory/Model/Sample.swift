//
//  Sample.swift
//  Car Inventory
//
//  Created by user163027 on 3/30/20.
//  Copyright © 2020 Arthur Ataide. All rights reserved.
//

import Foundation
class Sample{
    func run(){
        //Single instance
        let databaseManager = DatabaseManager.getInstance()
        //Set entity
        databaseManager.setEntityName("User_type_Entity")
        
        //Remove all rows
        databaseManager.removeAll()
        
        //Remove a specific row
        //databaseManager.removeRowByIndex(index: 0)
        
        //Creating object
        var vendorType = UserType()
        vendorType.id = 1
        vendorType.name = "Vendor"
        
        
        //Casting to AnyObject
        let data =
            vendorType as AnyObject
        //Adding row
        databaseManager.addRow(data)
        
        //Creating object
        var managerType = UserType()
        managerType.id = 2
        managerType.name = "Admin"
        //Adding row
        databaseManager.addRow(managerType as AnyObject)
        
        //Getting list
        let anyList = databaseManager.toList()
        
        for any in anyList{
            //Casting to entity class
            let userType = any as! UserType
            
            print(userType.id!)
            print(userType.name!)
            print("----")
        }
        
        //Changing value
        managerType.name = "Manager"
        //Selecting object
        databaseManager.modifyRow(data: managerType as AnyObject, index:1);
        
        //Printing a specific row
        print(databaseManager.toList()[1] as! UserType);
        
        //Change entity
        databaseManager.setEntityName("UserEntity")
        databaseManager.removeAll()
        
        //Creating object
        var user = User()
        user.email = "vendor@car.com"
        user.name = "John Smith"
        user.password = "1234"
        user.accountType = 1
        //Adding row
        databaseManager.addRow(user as AnyObject)
        
        //Printing a specific row
        print(databaseManager.toList()[0] as! User);
        
        //Changing password
        user.password = "1235"
        
        databaseManager.modifyRow(data: user as AnyObject, index: 0)
        
        //Printing a specific row
        print(databaseManager.toList()[0] as! User);
        
        //Change entity
        databaseManager.setEntityName("CarEntity")
        databaseManager.removeAll()
        
        var car1 = Car()
        car1.name = "Honda Civic"
        car1.vin = "SJDU5D895FF"
        car1.model = "Honda Civic"
        car1.year = 2020
        car1.image = "civic photo"
        car1.price = 20000
        car1.color = "Blue"
        databaseManager.addRow(car1 as AnyObject)
        
        var car2 = Car()
        car2.name = "Toyota Corolla"
        car2.vin = "5DFG4SJDU5D8"
        car2.model = "Toyota Corolla"
        car2.year = 2010
        car2.image = "corolla photo"
        car2.price = 10000
        car2.color = "White"
        databaseManager.addRow(car2 as AnyObject)
        
        //Printing a specific row
        for any in databaseManager.toList(){
            //Casting to entity class
            let car = any as! Car
            
            print("----")
            print(car)
            print("----")
        }
    }
    
    func insertDummyData(){
        //Single instance
        let databaseManager = DatabaseManager.getInstance()
        //Set entity
        databaseManager.setEntityName("User_type_Entity")
        
        if databaseManager.toList().count == 0{
            
            //Creating object
            var vendorType = UserType()
            vendorType.id = 1
            vendorType.name = "Vendor"
            
            //Adding row
            databaseManager.addRow(vendorType as AnyObject)
            
            //Creating object
            var managerType = UserType()
            managerType.id = 2
            managerType.name = "Manager"
            //Adding row
            databaseManager.addRow(managerType as AnyObject)
        }
        
        //Set entity
        databaseManager.setEntityName("UserEntity")
               
        if databaseManager.toList().count == 0{
            //Creating user
            var userVendor = User()
            userVendor.email = "vendor@car.com"
            userVendor.name = "John Smith"
            userVendor.password = "1234"
            userVendor.accountType = 1
            //Adding row
            databaseManager.addRow(userVendor as AnyObject)
            
            //Creating user
            var managerVendor = User()
            managerVendor.email = "manager@car.com"
            managerVendor.name = "Peter Park"
            managerVendor.password = "1234"
            managerVendor.accountType = 2
            //Adding row
            databaseManager.addRow(managerVendor as AnyObject)
        }
        
        //Change entity
        databaseManager.setEntityName("CarEntity")
        //databaseManager.removeAll()
        if databaseManager.toList().count == 0{
            var car1 = Car()
            car1.name = "Brand New Honda Civic"
            car1.vin = "SJDU5D895FF"
            car1.model = "Honda Civic"
            car1.year = 2020
            car1.image = "honda_civic_photo"
            car1.price = 20000
            car1.color = "Blue"
            databaseManager.addRow(car1 as AnyObject)
            
            var car2 = Car()
            car2.name = "Used Toyota Corolla"
            car2.vin = "5DFG4SJDU5D8"
            car2.model = "Toyota Corolla"
            car2.year = 2010
            car2.image = "toyota_corolla_photo"
            car2.price = 10000
            car2.color = "White"
            databaseManager.addRow(car2 as AnyObject)
        }
        
    }
    
}

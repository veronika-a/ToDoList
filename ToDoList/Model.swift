//
//  Model.swift
//  ToDoList
//
//  Created by Veronika Andrianova on 22.06.2020.
//  Copyright © 2020 Veronika Andrianova. All rights reserved.
//

import Foundation


var ToDoItems : [[String : Any]] {
    get{
        if let array = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String:Any]]{
             return array
         } else {
             return []
         }
    }
    
    set{
        UserDefaults.standard.set(newValue, forKey: "ToDoDataKey")
        UserDefaults.standard.synchronize()
    }
}

var Users : [[String : Any]] {
    get{
        if let array = UserDefaults.standard.array(forKey: "UserDataKey") as? [[String:Any]]{
             return array
         } else {
             return []
         }
    }
    
    set{
        UserDefaults.standard.set(newValue, forKey: "UserDataKey")
        UserDefaults.standard.synchronize()
    }
}

func addNewUser(nameUser: String, money: Double = 0){
    Users.append(["Name": nameUser, "Money": money] )
}

func removeUser(at index: Int){
    Users.remove(at: index)
}
func editUser(at index: Int){
    
}
func cashUser(sum: Double, index: Int) -> Float{
   // Users.formIndex(after: index)
    let cash =  (Users[index]["Money"] as! Float) - Float(sum)/(Float(Users.count))
    return cash
}

func addItem(nameItem: String, isCompleted : Bool =  true, price : Double = 0 , amount: Int = 1){
    ToDoItems.append(["Name": nameItem, "isCompleted" : isCompleted, "Price" : price] )
}

func addUserItem(item : Int, masUsers : [String] = [] ){
    if( masUsers == [] ){
        var masU = [String]()
        for i in 0..<Users.count {
            masU.append(Users[i]["Name"] as! String)
        }
        ToDoItems[item]["Users"] = masU
    }
    else {
       ToDoItems[item]["User"] = masUsers
    }
}

func removeItem(at index: Int){
    ToDoItems.remove(at: index)
}

func changeState(at item : Int ) -> Bool {
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    return (ToDoItems[item]["isCompleted"]) as! Bool
}

func changePrice(at item : Int , price : Double) -> Double {
    ToDoItems[item]["Price"] = price
    return ToDoItems[item]["Price"] as! Double
}

func moveItem(fromIndex: Int, toIndex: Int){

    let from = ToDoItems[fromIndex]
    ToDoItems.remove(at: fromIndex)
    ToDoItems.insert(from, at: toIndex)
}

func priceSum() -> Double {
    var sum = 0.0
    for i in 0..<ToDoItems.count {
        if( (ToDoItems[i]["isCompleted"] as! Bool ) == true)
        {
            sum += ToDoItems[i]["Price"] as! Double
        }
    }
    return sum
}


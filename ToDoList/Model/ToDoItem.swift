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


func addItem(nameItem: String,
             isCompleted : Bool =  true,
             price : Double = 0 ,
             amount: Int = 1,
             masUsers : [String] = [])
{
        ToDoItems.append([
            "Name": nameItem,
            "isCompleted" : isCompleted,
            "Price" : price,
            "Users": masUsers] )
}


func editItem(index: Int,
              nameItem: String,
              price : Double = 0,
              amount: Int = 1,
              masUsers : [String]){
     ToDoItems[index]["Name"] = nameItem
     ToDoItems[index]["Price"] = price
     ToDoItems[index]["Users"] = masUsers
}


func addItemI(nameItem: String, isCompleted : Bool =  true, price : Double = 0 , amount: Int = 1){
    ToDoItems.append([
        "Name": nameItem,
        "isCompleted" : isCompleted,
        "Price" : price] )
}

func addUserItem(nameItem : String, masUsers : [String] = [] ){
    var numItem : Int = 0
    for n in 0..<ToDoItems.count {
        if( ToDoItems[n]["Name"] as! String == nameItem){
        numItem = n
        }
    }
    if( masUsers == [] ){
        var masU = [String]()
        for i in 0..<Users.count {
            masU.append(Users[i]["Name"] as! String)
        }
        ToDoItems[numItem]["Users"] = masU
    }
    else {
       ToDoItems[numItem]["User"] = masUsers
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


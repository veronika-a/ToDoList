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
func editUser(index: Int, name: String, money: Double){
        Users[index]["Name"] = name
        Users[index]["Money"] = money
}


func cashUserI(sum: Double, index: Int) -> Float{
    let UsersMoney =  (Users[index]["Money"] as! Float)
    let Sum = Float(sum)
    
    let cash = UsersMoney - Sum/(Float(Users.count)) //sameSum
    return cash
}

func cashUser(sum: Double, index: Int) -> Float{
   // Users.formIndex(after: index)
    var cash : Float = 0
    let UsersMoney =  (Users[index]["Money"] as! Float)
    //var Us = [String]()
    var sumU : Double = 0
    let ItemsCount = ToDoItems.count
    var UsCount : Int = 0
    
    for u in 0..<ItemsCount {
        if(ToDoItems[u]["isCompleted"] as! Bool){
        let Us = ToDoItems[u]["Users"] as! [String]
        UsCount = Us.count
        for s in 0..<UsCount {
            if(Us[s] == Users[index]["Name"] as! String){
                sumU += (ToDoItems[u]["Price"] as! Double ) / Double(UsCount)
            }
            }
        }
    }
    
    cash = UsersMoney - (Float(sumU))
    return cash
}


func addItem(nameItem: String,
             isCompleted : Bool =  true,
             price : Double = 0 ,
             amount: Int = 1,
             masUsers : [String] = [])
{
    
//       if( masUsers == [] ){
//           var masU = [String]()
//           for i in 0..<Users.count {
//               masU.append(Users[i]["Name"] as! String)
//           }
//        ToDoItems.append(["Name": nameItem, "isCompleted" : isCompleted, "Price" : price, "Users": masU] )
//       }
//       else {
    
        ToDoItems.append(["Name": nameItem, "isCompleted" : isCompleted, "Price" : price, "Users": masUsers] )

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
    ToDoItems.append(["Name": nameItem, "isCompleted" : isCompleted, "Price" : price] )
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


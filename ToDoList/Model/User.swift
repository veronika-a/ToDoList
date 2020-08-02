//
//  User.swift
//  ToDoList
//
//  Created by Veronika Andrianova on 02.08.2020.
//  Copyright © 2020 Veronika Andrianova. All rights reserved.
//

import Foundation

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
    let remUser = Users[index]["Name"] as! String
    var users = [String]()
    for item in 0..<ToDoItems.count {
        users = ToDoItems[item]["Users"] as! [String]
        for us in 0..<users.count {
            if(users[us] == remUser){
                users.remove(at: us)
                ToDoItems[item]["Users"] = users
            }
        }
    }
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


func usersTotalMoney() ->Double {
    var sum = 0.0
    for user in 0..<Users.count {
        sum += Users[user]["Money"] as! Double
    }
    
    return sum
}


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



func addItem(nameItem: String, isCompleted : Bool = false){
    ToDoItems.append(["Name": nameItem, "isCompleted" : isCompleted])
}

func removeItem(at index: Int){
    ToDoItems.remove(at: index)
}

func changeState(at item : Int ) -> Bool {
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    return (ToDoItems[item]["isCompleted"]) as! Bool
}


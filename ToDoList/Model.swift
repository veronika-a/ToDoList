//
//  Model.swift
//  ToDoList
//
//  Created by Veronika Andrianova on 22.06.2020.
//  Copyright © 2020 Veronika Andrianova. All rights reserved.
//

import Foundation


var ToDoItems : [[String : Any]] = [["Name":"Позвонить маме", "isCompleted" : "true"],["Name":"Дописать приложение", "isCompleted" : "false"],["Name":"Отметить", "isCompleted" : "false"]]

func addItem(nameItem: String, isCompleted : Bool = false){
    ToDoItems.append(["Name": nameItem, "isCompleted" : false])
    saveData()
}

func removeItem(at index: Int){
    ToDoItems.remove(at: index)
    saveData()
}

func changeState(at item : Int ){
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    saveData()
}

func saveData(){
    print("save")
}

func loadData(){
    
}

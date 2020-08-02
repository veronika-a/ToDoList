//
//  NewItemViewController.swift
//  ToDoList
//
//  Created by Veronika Andrianova on 03.07.2020.
//  Copyright © 2020 Veronika Andrianova. All rights reserved.
//

import UIKit

class NewItemVC: UIViewController ,UITableViewDelegate, UITableViewDataSource {
   
    var currState: Bool = true
    var currItem: Int = 0
    
    @IBOutlet weak var TitleItem: UILabel!
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var UsersTV: UITableView!

    @IBOutlet weak var PriceTf: UITextField!
    
    @available(iOS 13.0, *)
    @IBAction func Done(_ sender: Any) {
        let newItem = NameTF.text
         let newPrice =  PriceTf.text ?? "0.0"
         let newPriceD = Double(newPrice) ?? 0.0
        
        var masU = [String]()

       let cells = UsersTV.visibleCells

      for cell in cells {
        if(cell.imageView?.image == UIImage(named: "check")){
                masU.append(cell.textLabel?.text ?? "" )
            }
        }
        if(currState){
         addItem(nameItem: newItem!, price: newPriceD,  masUsers: masU)
        }
        else{
            editItem(index: currItem, nameItem: newItem!, price: newPriceD, masUsers: masU)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
      
         guard let tableVC = storyboard.instantiateViewController(identifier: "ToDoItems") as? TableVC else { return }
        show(tableVC, sender: nil)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
              // #warning Incomplete implementation, return the number of sections
           return 1
           
       }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             // #warning Incomplete implementation, return the number of rows
             return Users.count
         }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let currentItem = Users[indexPath.row]
              cell.textLabel?.text = currentItem["Name"] as? String
        if(currState){
            cell.imageView?.image = UIImage(named: "check")
        }
        else{
            cell.imageView?.image = UIImage(named: "uncheck")
            let masU = ToDoItems[currItem]["Users"] as! [String]
            for item in 0..<masU.count {
                if(masU[item] == cell.textLabel?.text){
                    cell.imageView?.image = UIImage(named: "check")
                }
            }
        }

        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UsersTV.delegate = self
        UsersTV.dataSource = self
        
        if(!currState){
            TitleItem.text = "Update item"
            NameTF.text =  ToDoItems[currItem]["Name"] as? String
            let price = ToDoItems[currItem]["Price"] as? Double
            PriceTf.text = String(format:"%.1f", price!)
        }
                
        // Do any additional setup after loading the view.
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          UsersTV.deselectRow(at: indexPath, animated: true)
        

          if (UsersTV.cellForRow(at: indexPath)? .imageView?.image == UIImage(named: "uncheck")){
              UsersTV.cellForRow(at: indexPath)? .imageView?.image = UIImage(named: "check")
          } else {
               UsersTV.cellForRow(at: indexPath)? .imageView?.image = UIImage(named: "uncheck")
          }
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
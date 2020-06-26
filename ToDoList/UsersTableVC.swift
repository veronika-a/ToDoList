//
//  UsersTableVC.swift
//  ToDoList
//
//  Created by Veronika Andrianova on 26.06.2020.
//  Copyright © 2020 Veronika Andrianova. All rights reserved.
//

import UIKit

class UsersTableVC: UITableViewController {

    @IBAction func EditUsers(_ sender: Any) {
        
    }
    @IBAction func AddUser(_ sender: Any) {
        let alertController = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
              alertController.addTextField { (textField) in
                  textField.placeholder = "New user name"
              }
              alertController.addTextField { (textField2) in
                        textField2.placeholder = "Money"
                    }
              
              let alertAction1 = UIAlertAction(title: "Cancel", style: .default)
              { (alert) in
                  
              }
              let alertAction2 = UIAlertAction(title: "Create", style: .cancel)
                    { (alert) in
                        //добавить новую запись
                     let newUserItem = alertController.textFields![0].text
                      let moneyUser =  alertController.textFields![1].text ?? "0.0"
                        let moneyUserD = Double(moneyUser) ?? 0.0
                        addNewUser(nameUser: newUserItem!, money: moneyUserD)
                      
                      self.tableView.reloadData()
                    }
              
              alertController.addAction(alertAction1)
              alertController.addAction(alertAction2)

              present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

     override func numberOfSections(in tableView: UITableView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 1
       }
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return Users.count
       }


     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellUser", for: indexPath)

        let currentItem = Users[indexPath.row]
        let moneyU = currentItem["Money"] as! Double
        let moneyUS: String = String(format:"%.1f", moneyU)
        
        cell.textLabel?.text = currentItem["Name"] as? String
        cell.detailTextLabel?.text = moneyUS
           
           return cell
       }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

  // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete
           {
               // Delete the row from the data source
               removeUser(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)
           } else if editingStyle == .insert {
               // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
           }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

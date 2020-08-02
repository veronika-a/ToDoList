//
//  TableViewController.swift
//  ToDoList
//
//  Created by Veronwika Andrianova on 22.06.2020.
//  Copyright © 2020 Veronika Andrianova. All rights reserved.
//

import UIKit


class TableVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.groupTableViewBackground
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let currentItem = ToDoItems[indexPath.row]
        let price = currentItem["Price"] as? Double
        let priceS : String = String(format:"%.1f", price!)
        
        cell.textLabel?.text = currentItem["Name"] as? String
        cell.detailTextLabel?.text = priceS
        
        if (currentItem["isCompleted"] as! Bool == true ) {
            cell.imageView?.image = UIImage(named: "check")
        }
        else {
             cell.imageView?.image = UIImage(named: "uncheck")
        }
        
        if( tableView.isEditing){
            cell.textLabel?.alpha = 0.4
            cell.imageView?.alpha = 0.4
            
        } else{
            cell.textLabel?.alpha = 1
            cell.imageView?.alpha = 1
        }
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        tableView.allowsSelectionDuringEditing = true
               tableView.allowsSelection = true
        
        if(!tableView.isEditing){
        if changeState(at: indexPath.row){
            tableView.cellForRow(at: indexPath)? .imageView?.image = UIImage(named: "check")
        } else {
             tableView.cellForRow(at: indexPath)? .imageView?.image = UIImage(named: "uncheck")
        }
        }
         else{
        if #available(iOS 13.0, *) {
            showTVC(index: indexPath.row)
        } else {
            // Fallback on earlier versions
        }
        }
    }
    
    @available(iOS 13.0, *)
    func showTVC(index: Int){
   
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
           guard let editItem = storyboard.instantiateViewController(identifier: "NewItemVC") as? NewItemVC else { return }
        editItem.currState = false
        editItem.currItem = index
        show(editItem, sender: nil)
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if(tableView.isEditing){
            return .none
        } else {
            return .delete
        }
        
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        
        return false
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
                   showTVC(index: indexPath.row)
        }
        }
    
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

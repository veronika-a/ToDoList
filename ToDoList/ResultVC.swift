//
//  ResultsVC.swift
//  ToDoList
//
//  Created by Veronika Andrianova on 25.06.2020.
//  Copyright © 2020 Veronika Andrianova. All rights reserved.
//

import UIKit

class ResultVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
     @IBOutlet weak var UsersTableView: UITableView!
    @IBOutlet weak var CheckSum: UILabel!
    @IBOutlet weak var CommomSum: UILabel!

   
    func numberOfSections(in tableView: UITableView) -> Int {
           // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          // #warning Incomplete implementation, return the number of rows
          return Users.count
      }


     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "UsersCell", for: indexPath)

           let currentItem = Users[indexPath.row]
        let cashU = cashUser(sum: priceSum(), index: indexPath.row)
           let cashUD: String = String(format:"%.1f", cashU)
           
           cell.textLabel?.text = currentItem["Name"] as? String
           cell.detailTextLabel?.text = cashUD
              
              return cell
          }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UsersTableView.delegate = self
        UsersTableView.dataSource = self
        UsersTableView.reloadData()
        CheckSum.text = String(format:"%.1f", priceSum())
        CommomSum.text = String(format:"%.1f", usersTotalMoney())


        // Do any additional setup after loading the view.
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

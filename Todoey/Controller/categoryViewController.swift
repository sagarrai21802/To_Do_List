//
//  categoryViewController.swift
//  Todoey
//
//  Created by Apple on 12/08/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import CoreData
class categoryViewController: UITableViewController {
    
      let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryItem : [String] = ["TO BUY", "TO Sell" , "To order"]
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    
    // MARK: - This function is used in returning the number of rows in the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItem.count
    }
    
    
    //MARK: - this function will fill data with the string in cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryIdentifier", for : indexPath)
//        var dataitems = categoryItem[indexPath.row]
        cell.textLabel?.text = categoryItem[indexPath.row]
        return cell
    }
    
    
    
    
    

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        var UItextfield = UITextField()
        
        let  alert = UIAlertController(title: "Add Category", message: "add title of the category", preferredStyle: .alert)
          
        
        alert.addTextField() { alertfield in
            alertfield.placeholder = "Enter a category name"
            UItextfield = alertfield
        }
        
        let addbutton = UIAlertAction(title: "Add", style: .default) { add in
            // this will say what should happen
            print("success")
            self.categoryItem.append(UItextfield.text!)
        
            
        }
        
        let cancelbutton = UIAlertAction(title : "Cancel" , style: .cancel) { cancel in
            
            print("cancelled")
        }
        
        
        
        
        alert.addAction(addbutton)
        alert.addAction(cancelbutton)
        present(alert, animated: true, completion: nil)
    }
   

}

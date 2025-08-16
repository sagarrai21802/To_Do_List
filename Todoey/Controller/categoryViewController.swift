//
//  categoryViewController.swift
//  Todoey
//
//  Created by Apple on 12/08/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
//import CoreData
import CoreData
class categoryViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var categoryItem = [Category]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
     loadcategories()
        
    }
    
    
    // MARK: - This function is used in returning the number of rows in the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItem.count
    }
    
    
    //MARK: - this function will fill data with the string in cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryIdentifier", for : indexPath)
//        var dataitems = categoryItem[indexPath.row]
        cell.textLabel?.text = categoryItem[indexPath.row].items
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotonotes", sender: self)
    }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TableViewController
        
        if let indexpath = tableView.indexPathForSelectedRow {
            destinationVC.selectedItem = categoryItem[indexpath.row]
        }
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
            let newitem = Category(context : self.context)
            newitem.items = UItextfield.text
            self.categoryItem.append(newitem) 
            self.savedata()
            
           
        
            
        }
        
        let cancelbutton = UIAlertAction(title : "Cancel" , style: .cancel) { cancel in
            
            print("cancelled")
        }
        
        
        
        
        alert.addAction(addbutton)
        alert.addAction(cancelbutton)
        present(alert, animated: true, completion: nil)
    }
    func loadcategories() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categoryItem = try context.fetch(request)
            tableView.reloadData()
        } catch {
            print(error)
        }
     
        
    }
    func savedata(){
        do {
            try context.save()
            self.tableView.reloadData()
        } catch {
            print(error)
        }

    }

}

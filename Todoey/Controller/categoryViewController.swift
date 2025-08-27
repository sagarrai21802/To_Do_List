//
//  categoryViewController.swift
//  Todoey
//
//  Created by Apple on 12/08/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
//import SwipeCellKit

class categoryViewController: SwipeTableViewController  {

    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let realm = try! Realm()
    var categoryItem : Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
     loadcategories()
        
        tableView.rowHeight = 80.0
        
        
    }
    
    
    // MARK: - This function is used in returning the number of rows in the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItem?.count ?? 1
    }
    
    
    //MARK: - this function will fill data with the string in cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        cell.textLabel?.text = categoryItem?[indexPath.row].title ?? "NO CATEGORY TILL NOW"
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotonotes", sender: self)
        print("done segue")
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TableViewController
        if let indexpath = tableView.indexPathForSelectedRow {
            print("after this the categroy item will get setted in the prepare segue")
            destinationVC.selectedItem = categoryItem?[indexpath.row]
            print("done setting")
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
            let newitem = Category()
            newitem.title = UItextfield.text!
//            self.categoryItem.append(newitem)
            self.savedata(category : newitem)
            
           
        
            
        }
        
        let cancelbutton = UIAlertAction(title : "Cancel" , style: .cancel) { cancel in
            
            print("cancelled")
        }
        
        
        
        
        alert.addAction(addbutton)
        alert.addAction(cancelbutton)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func loadcategories() {
        
        categoryItem = realm.objects(Category.self)
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//        
//        do {
//            categoryItem = try context.fetch(request)
//            tableView.reloadData()
//        } catch {
//            print(error)
//        }
     
        
    }
    
    
    
    
    override func updatetable(at indexpath: IndexPath) {
        if let currentcategory = self.categoryItem?[indexpath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(currentcategory)
                }
            } catch {
                print("failed to delete the cell")
            }

        }

    }
    
    
    //MARK: - LETS EDIT THE TEXT INSIDE THE LABEL
    override func updatetext(at indexpath: IndexPath) {
        if let selecteditem = categoryItem?[indexpath.row] {
          

            var UItextfield = UITextField()
            
            let  alert = UIAlertController(title: "Update", message: "update the new name of category", preferredStyle: .alert)
              
    
            alert.addTextField() { alertfield in
                alertfield.placeholder = "\(selecteditem.title)"
                UItextfield = alertfield
            }
            
            let addbutton = UIAlertAction(title: "Add", style: .default) { add in
                // this will say what should happen
                print("success")
              //  let newitem = Category()
     
                do {
                    try self.realm.write {
                        selecteditem.title = UItextfield.text!
                        self.realm.add(selecteditem)
                    }
                } catch {
                    print("failed to update data")
                }
              //  newitem.title = UItextfield.text!
    //            self.categoryItem.append(newitem)
               // self.savedata(category : selecteditem)
                self.tableView.reloadData()
               
            }
            
            let cancelbutton = UIAlertAction(title : "Cancel" , style: .cancel) { cancel in
                
                print("cancelled")
            }
            
            
            
            
            alert.addAction(addbutton)
            alert.addAction(cancelbutton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func savedata(category : Category){
        do {
//            try context.save()
            self.tableView.reloadData()
            try  realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
    }

}

extension categoryViewController : UISearchBarDelegate {

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
            if let query = searchBar.text, !query.isEmpty {
                categoryItem =  categoryItem?
                    .filter("title CONTAINS[cd] %@", query)
                    .sorted(byKeyPath: "title", ascending: true)
            }
            tableView.reloadData()
        }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadcategories()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                
        }
        }
        
    }
     
}


//extension categoryViewController : SwipeTableViewCellDelegate {
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//            // handle action by updating model with deletion
//            if let categorydeetion = self.categoryItem?[indexPath.row] {
//                do {
//                    try self.realm.write {
//                        self.realm.delete(categorydeetion)
//                    }
//                } catch {
//                    print("failed in deleting item \(error)")
//                }
//                
//            }
////            tableView.reloadData()
//
//            }
//        
//        // customize the action appearance
//        deleteAction.image = UIImage(named: "delete")
//
//        return [deleteAction]
//    }
//    
//    
//    
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
////        options.transitionStyle = .border
//        return options
//    }
//}

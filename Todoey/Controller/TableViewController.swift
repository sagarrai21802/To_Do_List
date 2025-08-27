//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.


import UIKit
import CoreData
import RealmSwift

class TableViewController:  SwipeTableViewController {

    
    let realm = try! Realm()
    
    var dataitem : Results<Items>?
    
    var selectedItem : Category? {
        didSet{
            loadData()
        }
    }
    
    
    //MARK: - VIEW DID LOAD UP
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadData()
        tableView.rowHeight = 80.0
    }
    
    
    
    
    //MARK: - NUmber of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataitem?.count ?? 1
    }
    
    
    
    
    // MARK: - setting task into cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = dataitem?[indexPath.row] {
            cell.textLabel?.text = item.name
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "Till now we don't have any item in it"
        }
        return cell
    }
    
    
    
    override func updatetable(at indexpath: IndexPath) {
        if let selecteditem = dataitem?[indexpath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(selecteditem)
                }
            } catch {
                print("failed to delete the item from the table\(error)")
            }
        }
    }
    
    
//     MARK: - checkmark adding on selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = dataitem?[indexPath.row]{
            do {
                try realm.write {
                    item.done = !item.done
                    
                }
            } catch {
                print("error saving done property\(error)")
            }
        }
        
        
        /*
         if let item = dataitem?[indexPath.row]{
             do {
                 try realm.write {
                  realm.delete(item)                this will delete the data from the table
                     
                 }
             } catch {
                 print("error saving done property\(error)")
             }
         }
         */
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    
    //MARK: - NOW EFINTING INSIDE THE CELL OF THE ITEMS
    override func updatetext(at indexpath: IndexPath) {
        if let selecteditem = dataitem?[indexpath.row] {
          

            var UItextfield = UITextField()
            
            let  alert = UIAlertController(title: "Update", message: "update the new name of category", preferredStyle: .alert)
              
    
            alert.addTextField() { alertfield in
                alertfield.placeholder = "\(selecteditem.name)"
                UItextfield = alertfield
            }
            
            let addbutton = UIAlertAction(title: "Add", style: .default) { add in
                // this will say what should happen
                print("success")
              //  let newitem = Category()
     
                do {
                    try self.realm.write {
                        selecteditem.name = UItextfield.text!
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
    
    
    
    // here we are going to make a button that will make a new cell for every new work you are doing
    //MARK: - this function is for adding an item in that array means the add button
    @IBAction func addbutton(_ sender: UIBarButtonItem) {
        
        var usertextfield = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "add an item", preferredStyle: .alert)
        
        alert.addTextField() { alertfield in
            alertfield.placeholder = "item name"
            usertextfield = alertfield
        }
        
        
        
        
        
        let addbutton = UIAlertAction(title: "Add", style: .default) { add in
            // this will say what should happen
            print("success")
            if let currentcategory = self.selectedItem {
                do {
                    try self.realm.write {
                        let newItem = Items()
                        newItem.name = usertextfield.text!
                        newItem.dateadded = Date()
                        currentcategory.item.append(newItem)
                    }
                } catch {
                    print("error saving data in items")
                }
            }
            self.tableView.reloadData()
           
            //newItem.parentCategory = self.selectedItem
//            self.dataitem.append(newItem)
            
//            self.saveitems()
            
        }
        
        
        
        
        
        let cancelbutton = UIAlertAction(title : "Cancel" , style: .cancel) { cancel in
            
            print("cancelled")
        }
        
        
        alert.addAction(addbutton)
        alert.addAction(cancelbutton)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - making a function for saving data
//    func saveitems() {
        
//        do {
//            try context.save()
//            tableView.reloadData()
//        } catch {
//            print("\(error)")
//        }

//    }
    
//    MARK: - this is for the swipug effet of the apple
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        true
//    }
//    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let edit = UIAccessibilityTextualContext
//    }
//    
    
    
//    MARK: - Loading of data
    func loadData() {
        
        dataitem = selectedItem?.item.sorted(byKeyPath: "name", ascending: true)
        tableView.reloadData()
        
//        let cateegorypredicate = NSPredicate(format: "parentCategory.items MATCHES %@" , selectedItem!.items!)
        
//        if let additonalpredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [cateegorypredicate, additonalpredicate])
//        } else {
//            request.predicate = cateegorypredicate
//        }
//            do {
//                dataitem = try context.fetch(request)
//                tableView.reloadData()
//                
//            } catch {
//                print(error)
//            }
        
    }
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let edit = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
//            
//        }
//        edit.backgroundColor = .gray
//        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
//        
//        }
//        delete.backgroundColor = .red
//        let swipe = UISwipeActionsConfiguration(actions: [delete,edit])
//        return swipe
//    }
    
}


extension TableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let query = searchBar.text, !query.isEmpty {
            dataitem = selectedItem?.item
                .filter("name CONTAINS[cd] %@", query)
                .sorted(byKeyPath: "dateadded", ascending: true)
        }
        tableView.reloadData()
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        
//        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        
//        loadData(with : request)
//        do {
//               dataitem = try context.fetch(request)
//               tableView.reloadData()
//           } catch {
//               print("Fetch failed: \(error.localizedDescription)")
//           }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                
        }
        }
       
        
    }
}



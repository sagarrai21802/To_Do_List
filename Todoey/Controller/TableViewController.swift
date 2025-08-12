//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.


import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    var dataitem = [Item]()
    
    
    
    
    //MARK: - VIEW DID LOAD UP
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        loadData()
        
    }
    
    
    
    
    //MARK: - NUmber of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataitem.count
    }
    
    
    
    
    // MARK: - setting task into cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = dataitem[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    
    
    
    // MARK: - checkmark adding on selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        dataitem[indexPath.row].done.toggle()
        context.delete(dataitem[indexPath.row])
        dataitem.remove(at: indexPath.row)
        saveitems()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
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
            
            let newItem = Item(context: self.context)
            newItem.done = false
            newItem.title = usertextfield.text!
            self.dataitem.append(newItem)
            
            self.saveitems()
            
        }
        
        
        
        
        
        let cancelbutton = UIAlertAction(title : "Cancel" , style: .cancel) { cancel in
            
            print("cancelled")
        }
        
        
        alert.addAction(addbutton)
        alert.addAction(cancelbutton)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - making a function for saving data
    func saveitems() {
        
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
    }
    
    
    
    
    //MARK: - Loading of data
    func loadData(with request : NSFetchRequest<Item> = Item.fetchRequest()) {
      // let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            dataitem = try context.fetch(request)
            tableView.reloadData()
            
        } catch {
            print(error)
        }
    }
}


extension TableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadData(with : request)
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



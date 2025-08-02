//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var dataitem = [ "hey mike", "hello" ,"find remote","ssg","sgrssrg","sgrsr","srgsrgsr","srgsgr","sgrsra","sfse","sgrvaa","a","f","v","afw","vse","mmf","mr","fmm"]
    var dataItem  = [ToDoList]()
    let userdefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = userdefaults.array(forKey: "TodoList") as? [String] {
            dataitem = item
        }      // Do any additional setup after loading the view.
    }
    
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("hello")
//        return dataitem.count
//    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataitem.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = dataitem[indexPath.row]
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(dataitem[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else  {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // here we are going to make a button that will make a new cell for every new work you are doing
    
    
    
    
    
    
    
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
            self.dataitem.append(usertextfield.text ?? "Data item")
         //   self.dataItem.append(Task)
            self.userdefaults.set(self.dataItem, forKey: "TodoList")
            self.tableView.reloadData()
            // in this we will suse the userinput and send it somehwere
        }
        
        
        let cancelbutton = UIAlertAction(title : "Cancel" , style: .cancel) { cancel in
            // do noth
            //g
            print("cancelled")
        }
        
        
        alert.addAction(addbutton)
        alert.addAction(cancelbutton)
        present(alert, animated: true, completion: nil)
    }
}



// we are going to use userfdefaults to save the data from the applicatio to a plist inside the macos , and fo rthat we just need ot do ne thing that is use userdefault s

//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var dataitem = [ToDoList]()
    let datafilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    //var dataItem  = [ToDoList]()
    let userdefaults = UserDefaults.standard
    //MARK: - VIEW DID LOAD UP
    override func viewDidLoad() {
        super.viewDidLoad()
      loadData()
//        if let item = userdefaults.array(forKey: "TodoList") as? [String] {
//            dataitem = item
//        }      // Do any additional setup after loading the view.
//        print(datafilepath)
        
        
//        var item1 = ToDoList()
//        item1.Task = "Find me"
//        dataitem.append(item1)
//        
//        
//        var item2 = ToDoList()
//        item2.Task = "Find mini"
//        dataitem.append(item2)
//        
//        var item3 = ToDoList()
//        item3.Task = "Find myself"
//        dataitem.append(item3)
        
        
        
    }
    
 
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("hello")
//        return dataitem.count
//    }
    
    //MARK: - NUmber of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataitem.count
    }
    
    
    // MARK: - setting task into cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = dataitem[indexPath.row]
        cell.textLabel?.text = item.Task
        cell.accessoryType = item.Done ? .checkmark : .none
        return cell
    }
    
    
    // MARK: - checkmark adding on selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(dataitem[indexPath.row])
        
        
        dataitem[indexPath.row].Done.toggle()
        saveitems()
        //        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
////      dataitem[indexPath.row].Done = false
//            print(dataitem[indexPath.row].Done)
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else  {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//         //   dataitem[indexPath.row].Done = true
//            print(dataitem[indexPath.row].Done)
        
//        }
         
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
            var newitem = ToDoList()
            newitem.Task = usertextfield.text!
            self.dataitem.append(newitem)
             
            self.saveitems()
          
        //    self.userdefaults.set(self.dataitem, forKey: "TodoList")
         //   self.dataitem.append(usertextfield.text ?? "Data item")
         //   self.dataItem.append(Task)
         //   self.userdefaults.set(self.dataItem, forKey: "TodoList")

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
    
    //MARK: - making a function for saving data
    func saveitems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(dataitem)
            try  data.write(to : datafilepath!)
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Loading of data
    func loadData() {
        if let data = try? Data(contentsOf: datafilepath!) {
            let decoder = PropertyListDecoder()
            do {
                dataitem = try decoder.decode([ToDoList].self, from: data)
            } catch {
                print("Decoding error: \(error)")
            }
        }
    }
}



// we are going to use userfdefaults to save the data from the applicatio to a plist inside the macos , and fo rthat we just need ot do ne thing that is use userdefault s




////
////  categoryViewController.swift
////  Todoey
////
////  Created by Apple on 12/08/25.
////  Copyright © 2025 App Brewery. All rights reserved.
////
//
//import UIKit
//import RealmSwift
////import SwipeCellKit
//
//class categoryViewController: SwipeTableViewController  {
//
//
////    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    let realm = try! Realm()
//    var categoryItem : Results<Category>?
////    let ui = SwipeTableViewController
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//     loadcategories()
//
//        tableView.rowHeight = 80.0
//
//
//    }
//
//
//    // MARK: - This function is used in returning the number of rows in the table view
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return categoryItem?.count ?? 1
//    }
//
//
//    //MARK: - this function will fill data with the string in cell
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = super.tableView(tableView, cellForRowAt: indexPath)
////        cell.backgroundColor = categoryItem?[indexPath.row].color ?? UIColor.systemGray
////        cell.backgroundColor = categoryItem?[indexPath.row].color ?? "#3498DB"
////        cell.backgroundColor =  UIColor(named: "\(categoryItem?[indexPath.row].color ?? "#6495ED")
//        if let hex = categoryItem?[indexPath.row].color {
//            cell.backgroundColor = UIColor.fromHex(hex)
//        } else {
//            cell.backgroundColor = UIColor.gray
//        }
//        cell.textLabel?.text = categoryItem?[indexPath.row].title ?? "NO CATEGORY TILL NOW"
//
//        return cell
//    }
//
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "gotonotes", sender: self)
//        print("done segue")
//    }
//
//
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC = segue.destination as! TableViewController
//        if let indexpath = tableView.indexPathForSelectedRow {
//            print("after this the categroy item will get setted in the prepare segue")
//            destinationVC.selectedItem = categoryItem?[indexpath.row]
//            print("done setting")
//        }
//    }
//
//
//
//
//
//    @IBAction func addButton(_ sender: UIBarButtonItem) {
//        var UItextfield = UITextField()
//
//        let  alert = UIAlertController(title: "Add Category", message: "add title of the category", preferredStyle: .alert)
//
//
//        alert.addTextField() { alertfield in
//            alertfield.placeholder = "Enter a category name"
//            UItextfield = alertfield
//        }
//
//        let addbutton = UIAlertAction(title: "Add", style: .default) { add in
//            // this will say what should happen
//            print("success")
//            let newitem = Category()
//            newitem.title = UItextfield.text!
////            newitem.color = UIColor("\(randomFlat())")
////            newitem.color = UIColor.randomFlat()
////            self.categoryItem.append(newitem)
//            self.savedata(category : newitem)
//
//
//
//
//        }
//
//        let cancelbutton = UIAlertAction(title : "Cancel" , style: .cancel) { cancel in
//
//            print("cancelled")
//        }
//
//
//
//
//        alert.addAction(addbutton)
//        alert.addAction(cancelbutton)
//        present(alert, animated: true, completion: nil)
//    }
//
//
//
//    func loadcategories() {
//
//        categoryItem = realm.objects(Category.self)
////        let request : NSFetchRequest<Category> = Category.fetchRequest()
////
////        do {
////            categoryItem = try context.fetch(request)
////            tableView.reloadData()
////        } catch {
////            print(error)
////        }
//
//
//    }
//
//
//
//
//    override func updatetable(at indexpath: IndexPath) {
//        if let currentcategory = self.categoryItem?[indexpath.row] {
//            do {
//                try self.realm.write {
//                    self.realm.delete(currentcategory)
//                }
//            } catch {
//                print("failed to delete the cell")
//            }
//
//        }
//
//    }
//
//
//    //MARK: - LETS EDIT THE TEXT INSIDE THE LABEL
//    override func updatetext(at indexpath: IndexPath) {
//        if let selecteditem = categoryItem?[indexpath.row] {
//
//
//            var UItextfield = UITextField()
//
//            let  alert = UIAlertController(title: "Update", message: "update the new name of category", preferredStyle: .alert)
//
//
//            alert.addTextField() { alertfield in
//                alertfield.placeholder = "\(selecteditem.title)"
//                UItextfield = alertfield
//            }
//
//            let addbutton = UIAlertAction(title: "Add", style: .default) { add in
//                // this will say what should happen
//                print("success")
//              //  let newitem = Category()
//
//                do {
//                    try self.realm.write {
//                        selecteditem.title = UItextfield.text!
//                        selecteditem.color = UIColor.randomFlat()
//                        self.realm.add(selecteditem)
//                    }
//                } catch {
//                    print("failed to update data")
//                }
//              //  newitem.title = UItextfield.text!
//    //            self.categoryItem.append(newitem)
//               // self.savedata(category : selecteditem)
//                self.tableView.reloadData()
//
//            }
//
//            let cancelbutton = UIAlertAction(title : "Cancel" , style: .cancel) { cancel in
//
//                print("cancelled")
//            }
//
//
//
//
//            alert.addAction(addbutton)
//            alert.addAction(cancelbutton)
//            present(alert, animated: true, completion: nil)
//        }
//    }
//
//
//    func savedata(category : Category){
//        do {
////            try context.save()
//            self.tableView.reloadData()
//            try  realm.write {
//                realm.add(category)
//            }
//        } catch {
//            print(error)
//        }
//        tableView.reloadData()
//    }
//
//}
//
//extension categoryViewController : UISearchBarDelegate {
//
//        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//            if let query = searchBar.text, !query.isEmpty {
//                categoryItem =  categoryItem?
//                    .filter("title CONTAINS[cd] %@", query)
//                    .sorted(byKeyPath: "title", ascending: true)
//            }
//            tableView.reloadData()
//        }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadcategories()
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//
//        }
//        }
//
//    }
//
//}
//
//
////extension categoryViewController : SwipeTableViewCellDelegate {
//
////    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
////        guard orientation == .right else { return nil }
////
////        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
////            // handle action by updating model with deletion
////            if let categorydeetion = self.categoryItem?[indexPath.row] {
////                do {
////                    try self.realm.write {
////                        self.realm.delete(categorydeetion)
////                    }
////                } catch {
////                    print("failed in deleting item \(error)")
////                }
////
////            }
//////            tableView.reloadData()
////
////            }
////
////        // customize the action appearance
////        deleteAction.image = UIImage(named: "delete")
////
////        return [deleteAction]
////    }
////
////
////
////    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
////        var options = SwipeOptions()
////        options.expansionStyle = .destructive
//////        options.transitionStyle = .border
////        return options
////    }
////}


import UIKit
import RealmSwift
//import SwipeCellKit
//import ChameleonFramework

class categoryViewController: SwipeTableViewController  {
    
    let realm = try! Realm()
    var categoryItem : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadcategories()
        tableView.rowHeight = 80.0

    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
////        guard let navbar = navigationController?.navigationBar else {
////            fatalError("Some error occured in loading the navigtion bar of categoryviewcontroller")
////        }
////         
////        
////        navbar.barTintColor = .blue
////        navbar.tintColor = .black
////
////     let appearance = UINavigationBarAppearance()
////        appearance.backgroundColor = .blue
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navbar = navigationController?.navigationBar else {
            fatalError("Navigation bar not found")
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // ensures solid color
        appearance.backgroundColor = .systemPink
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Title color
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navbar.standardAppearance = appearance
        navbar.scrollEdgeAppearance = appearance // For large titles when scrolled
        navbar.compactAppearance = appearance // For compact nav bars (like in landscape)
        
        navbar.tintColor = .white // For back button and bar button items
    }
        
    // MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItem?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
//        // Use saved hex for background color
        if let hex = categoryItem?[indexPath.row].color {
            cell.backgroundColor = UIColor.fromHex(hex)
        } else {
            cell.backgroundColor = UIColor.gray
        }
//        cell.backgroundColor = UIColor(hexString: categoryItem?[indexPath.row].color ?? "#3fnedf")
        cell.textLabel?.text = categoryItem?[indexPath.row].title ?? "NO CATEGORY TILL NOW"
        return cell
    }
    
    // MARK: - TableView Delegate Methods
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
    
    // MARK: - Add New Category
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        var UItextfield = UITextField()
        
        let  alert = UIAlertController(title: "Add Category", message: "add title of the category", preferredStyle: .alert)
        
        alert.addTextField() { alertfield in
            alertfield.placeholder = "Enter a category name"
            UItextfield = alertfield
        }
        
        let addbutton = UIAlertAction(title: "Add", style: .default) { add in
            print("success")
            let newitem = Category()
            newitem.title = UItextfield.text!
            
            // Assign a random hex color when creating category
//            newitem.color = UIColor.randomHexColor()
            newitem.color = UIColor.randomHexColor()
            self.savedata(category : newitem)
        }
        
        let cancelbutton = UIAlertAction(title : "Cancel" , style: .cancel) { cancel in
            print("cancelled")
        }
        
        alert.addAction(addbutton)
        alert.addAction(cancelbutton)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Data Manipulation Methods
    func loadcategories() {
        categoryItem = realm.objects(Category.self)
        tableView.reloadData()
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
    
    //MARK: - WE MADE THIS FOR EDIT PURPOSE
    override func updatetext(at indexpath: IndexPath) {
        if let selecteditem = categoryItem?[indexpath.row] {
            var UItextfield = UITextField()
            
            let  alert = UIAlertController(title: "Update", message: "update the new name of category", preferredStyle: .alert)
            
            alert.addTextField() { alertfield in
                alertfield.placeholder = "\(selecteditem.title)"
                UItextfield = alertfield
            }
            
            let addbutton = UIAlertAction(title: "Add", style: .default) { add in
                print("success")
                do {
                    try self.realm.write {
                        selecteditem.title = UItextfield.text!
                        // Update color randomly on edit as well
//                        selecteditem.color = UIColor.randomFlat().hexValue()
                        self.realm.add(selecteditem)
                    }
                } catch {
                    print("failed to update data")
                }
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
            try realm.write {
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
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadcategories()
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadcategories()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                
        }
        }
    }
}

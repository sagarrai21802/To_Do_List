//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Apple on 26/08/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import SwipeCellKit
//import ChameleonFramework

class SwipeTableViewController: UITableViewController , SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for : indexPath) as! SwipeTableViewCell
        cell.backgroundColor = UIColor.randomFlat()
//        cell.backgroundColor = RandomFlatColor()
//        cell.backgroundColor = RandomFlatColor()
//        cell.backgroundColor = UIColor.randomFlat
         cell.delegate = self
         return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
          guard orientation == .right else { return nil }
  
          let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
              // handle action by updating model with deletion
//              if let categorydeetion = self.categoryItem?[indexPath.row] {
//                  do {
//                      try self.realm.write {
//                          self.realm.delete(categorydeetion)
//                      }
//                  } catch {
//                      print("failed in deleting item \(error)")
//                  }
//  
//              }
//  //            tableView.reloadData()
              self.updatetable(at : indexPath)
  
              }
        
        let EditAction = SwipeAction(style: .default , title: "Edit") { action, indexPath in
                // handle action by updating model with deletion
            self.updatetext(at : indexPath)
            }
        
  
          // customize the action appearance
          deleteAction.image = UIImage(named: "delete")
//        EditAction.image = UIImage(named: "Edit")
        EditAction.image = UIImage(systemName: "pencil")
        EditAction.backgroundColor = .gray
  
          return [deleteAction, EditAction]
      }
  
  
  
      func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
          var options = SwipeOptions()
          options.expansionStyle = .destructive
          return options
      }
    
    
    func updatetable(at indexpath : IndexPath) {
        // we wont do anything in it but will only do one thing that is using it for overriding it
    }
    
    
    func updatetext(at indexpath: IndexPath){
        
    }
}


extension UIColor {
    static func randomFlat() -> UIColor {
//        var hexcode : String?
        let colors: [UIColor] = [
            // System colors
            .systemRed, .systemBlue, .systemGreen,
            .systemOrange, .systemPink, .systemPurple,
            .systemTeal, .systemYellow, .systemIndigo,
            .systemBrown,
            .systemGray, .systemGray2, .systemGray3,
            .systemGray4, .systemGray5, .systemGray6,
            
            // Basic colors
            .black, .darkGray, .lightGray, .white,
            
            // Flat/Vibrant inspired colors
            UIColor(red: 0.94, green: 0.77, blue: 0.05, alpha: 1.0), // Sunflower
            UIColor(red: 0.91, green: 0.3,  blue: 0.24, alpha: 1.0), // Pomegranate
            UIColor(red: 0.18, green: 0.8,  blue: 0.44, alpha: 1.0), // Emerald
            UIColor(red: 0.20, green: 0.6,  blue: 0.86, alpha: 1.0), // Peter River
            UIColor(red: 0.61, green: 0.35, blue: 0.71, alpha: 1.0), // Amethyst
            UIColor(red: 0.2,  green: 0.29, blue: 0.37, alpha: 1.0), // Wet Asphalt
            UIColor(red: 0.16, green: 0.5,  blue: 0.73, alpha: 1.0), // Belize Hole
            UIColor(red: 0.75, green: 0.22, blue: 0.17, alpha: 1.0), // Alizarin
            UIColor(red: 0.95, green: 0.61, blue: 0.07, alpha: 1.0), // Carrot
            UIColor(red: 0.36, green: 0.64, blue: 0.86, alpha: 1.0), // Picton Blue
            UIColor(red: 0.56, green: 0.27, blue: 0.68, alpha: 1.0), // Wisteria
            UIColor(red: 0.10, green: 0.74, blue: 0.61, alpha: 1.0), // Turquoise
            UIColor(red: 0.34, green: 0.85, blue: 0.4,  alpha: 1.0), // Green Sea
            UIColor(red: 0.95, green: 0.77, blue: 0.06, alpha: 1.0), // Bright Sun
            UIColor(red: 0.85, green: 0.33, blue: 0.1,  alpha: 1.0), // Pumpkin
            UIColor(red: 0.91, green: 0.49, blue: 0.13, alpha: 1.0), // Orange Peel
            UIColor(red: 0.72, green: 0.52, blue: 0.04, alpha: 1.0), // Mustard
            UIColor(red: 0.23, green: 0.35, blue: 0.6,  alpha: 1.0), // Sapphire
            UIColor(red: 0.64, green: 0.16, blue: 0.16, alpha: 1.0), // Dark Red
            UIColor(red: 0.48, green: 0.82, blue: 0.92, alpha: 1.0), // Baby Blue
            UIColor(red: 0.29, green: 0.47, blue: 0.21, alpha: 1.0), // Forest Green
            UIColor(red: 0.92, green: 0.3,  blue: 0.39, alpha: 1.0), // Ruby
            UIColor(red: 0.88, green: 0.55, blue: 0.27, alpha: 1.0), // Copper
            UIColor(red: 0.55, green: 0.38, blue: 0.25, alpha: 1.0), // Coffee
            UIColor(red: 0.9,  green: 0.49, blue: 0.67, alpha: 1.0), // Raspberry Pink
            UIColor(red: 0.5,  green: 0.0,  blue: 0.5,  alpha: 1.0), // Purple Pure
            UIColor(red: 0.39, green: 0.58, blue: 0.93, alpha: 1.0), // Cornflower Blue
            UIColor(red: 0.93, green: 0.84, blue: 0.25, alpha: 1.0), // Goldenrod
            UIColor(red: 0.85, green: 0.64, blue: 0.13, alpha: 1.0), // Dark Goldenrod
            UIColor(red: 0.98, green: 0.5,  blue: 0.45, alpha: 1.0), // Salmon
            UIColor(red: 0.67, green: 0.9,  blue: 0.93, alpha: 1.0)  // Light Cyan
        ]
        
        return colors.randomElement() ?? .systemGray
    }
}

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
//        cell.backgroundColor = UIColor(named: UIColor.randomFlat())
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

//
//extension UIColor {
//    static func randomFlat() -> String {
////        var hexcode : String?
//        let colorHexCodes: [String] = [
//            // System-inspired colors
//            "#FF3B30", "#007AFF", "#34C759", "#FF9500", "#FF2D55",
//            "#AF52DE", "#5AC8FA", "#FFCC00", "#5856D6", "#A2845E",
//            "#8E8E93", "#AEAEB2", "#C7C7CC", "#D1D1D6", "#E5E5EA", "#F2F2F7",
//            
//            // Basic colors
//            "#000000", "#A9A9A9", "#D3D3D3", "#FFFFFF",
//            
//            // Flat/Vibrant inspired colors
//            "#F1C40F", "#E74C3C", "#2ECC71", "#3498DB", "#9B59B6", "#34495E",
//            "#2980B9", "#E74C3C", "#E67E22", "#5DADE2", "#8E44AD", "#1ABC9C",
//            "#2ECC71", "#F39C12", "#D35400", "#E67E22", "#B7950B", "#3A539B",
//            "#A93226", "#7FB3D5", "#196F3D", "#C0392B", "#CA6F1E", "#6E2C00",
//            "#E91E63", "#800080", "#6495ED", "#DAA520", "#B8860B", "#FA8072",
//            "#ADD8E6"
//        ]
//        
//        return colorHexCodes.randomElement() ?? "#6495ED"
//    }
//}

//
extension UIColor {
    // Convert hex string to UIColor
    static func fromHex(_ hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        // Fallback color if hex is invalid
        guard hexString.count == 6,
              let rgbValue = UInt64(hexString, radix: 16) else {
            return UIColor.gray
        }
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}

extension UIColor {
    // Generate random hex color string
    static func randomHexColor() -> String {
        let hexChars = "0123456789ABCDEF"
        var color = "#"
        for _ in 0..<6 {
            let randomIndex = Int.random(in: 0..<hexChars.count)
            let randomChar = hexChars[hexChars.index(hexChars.startIndex, offsetBy: randomIndex)]
            color.append(randomChar)
        }
        return color
    }
}

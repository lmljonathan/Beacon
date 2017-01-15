//
//  ListTableHelper.swift
//  Beacon
//
//  Created by Kenny Nguyen on 1/14/17.
//  Copyright © 2017 teamGo. All rights reserved.
//

import Foundation
import UIKit

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeIDs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlaceTableViewCell
        cell.selectionStyle = .none
        configureSwipeButtons(cell, mode: .view)
        DispatchQueue.main.async(execute: {
            cell.configure(with: self.placeArray[indexPath.row], mode: .more) {
                return cell
            }
        })
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showBusinessDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath) as! PlaceTableViewCell
        cell.mainView.backgroundColor = UIColor.selectedGray()
        cell.businessBackgroundImage.alpha = 0.8
        cell.ratingView.backgroundColor = UIColor.selectedGray()
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PlaceTableViewCell
        cell.mainView.backgroundColor = UIColor.white
        cell.businessBackgroundImage.alpha = 1
        cell.ratingView.backgroundColor = UIColor.clear
    }
    
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        if self.mode == .edit{
//            return true
//        }else{
//            return false
//        }
//    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Change this logic to match your needs.
        return (indexPath.section == 0)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Modify this code as needed to support more advanced reordering, such as between sections.
        let source = self.placeArray[sourceIndexPath.row]
        let destination = self.placeArray[destinationIndexPath.row]
        self.placeArray[sourceIndexPath.row] = destination
        self.placeArray[destinationIndexPath.row] = source
    }

    
    //    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
    //        let itemToMove = trip[(fromIndexPath as NSIndexPath).row]
    //        let placeItemToMove = placeArray[(fromIndexPath as NSIndexPath).row]
    //        let idOfItemToMove = placeIDs[(fromIndexPath as NSIndexPath).row]
    //
    //        trip.remove(at: (fromIndexPath as NSIndexPath).row)
    //        placeArray.remove(at: (fromIndexPath as NSIndexPath).row)
    //        placeIDs.remove(at: (fromIndexPath as NSIndexPath).row)
    //
    //        trip.insert(itemToMove, at: (toIndexPath as NSIndexPath).row)
    //        placeArray.insert(placeItemToMove, at: (toIndexPath as NSIndexPath).row)
    //        placeIDs.insert(idOfItemToMove, at: (toIndexPath as NSIndexPath).row)
    //    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete{
    //            trip.remove(at: (indexPath as NSIndexPath).row)
    //            placeArray.remove(at: (indexPath as NSIndexPath).row)
    //            placeIDs.remove(at: (indexPath as NSIndexPath).row)
    //            self.listTableView.deleteRows(at: [indexPath], with: .fade)
    //            self.listTableView.reloadData()
    //        }
    //        
    //    }
}

//
//  FirebaseHandler.swift
//  Beacon
//
//  Created by Jonathan Lam on 1/14/17.
//  Copyright © 2017 teamGo. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct FirebaseHandler{
    let ref = FIRDatabase.database().reference().child("places")

    //var trips: [Trip] = []
    //var tripToSave:Trip
    //var ref: FIRDatabaseReference!
    
    /*
     JSON
     
     trips:
        {tripID: ...(STRING),
            {   name: ... (STRING),
                create_by: 
                placeIDs: ... [array of STRING]
            }
        }
        ... more trips
     
     
     
     
    }
 
    */
    
    func getUserTrips(username: String, completion: (_: [Trip]) -> Void){
        
        completion([])
    }
    
    func saveTripToFirebase(id: String, username: String, trip: Trip){
        let placeIDList: [String] = trip.placeIDs // This needs to be saved within a trip
        
    }
    
    func registerUser(username: String, password: String){
        
    }
    
    
    func saveAndReload(tripToSave:Trip){
        print("saved")
        
        if tripToSave != nil{
            //saveTextToDataBase(trip: tripToSave)
            // FireBase
            let ref = FIRDatabase.database().reference().child("places")
            ref.queryOrdered(byChild: "created_by").queryEqual(toValue: FIRAuth.auth()?.currentUser?.uid).observe(.value, with: { snapshot in
                //self.trips.removeAll()
                for snap in snapshot.children.allObjects {
                    //let item = Trip(snapshot: snap as! FIRDataSnapshot)
                    //self.trips.append(item)
                }
                //self.tableView.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.automatic)
            })
            
        }
        //self.tableView.reloadData()
    }
    
    func saveTripToDataBase(trip: Trip) {
        var tripDict:[String:String] = [:]
        tripDict[trip.id] = trip.name
        ref.childByAutoId().setValue(tripDict)
    }
    
    
}

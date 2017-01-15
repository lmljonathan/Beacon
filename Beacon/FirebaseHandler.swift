//
//  FirebaseHandler.swift
//  Beacon
//
//  Created by Jonathan Lam on 1/14/17.
//  Copyright © 2017 teamGo. All rights reserved.
//

import Foundation
import Firebase

class FirebaseHandler: NSObject {
    
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
        
        completion()
    }
    
    func saveTripToFirebase(id: String, username: String, trip: Trip){
        let placeIDList: [String] = trip.placeIDs // This needs to be saved within a trip
        
    }
    
    func registerUser(username: String, password: String){
        
    }
    
}

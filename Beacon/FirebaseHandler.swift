//
//  FirebaseHandler.swift
//  Beacon
//
//  Created by Jonathan Lam on 1/14/17.
//  Copyright © 2017 teamGo. All rights reserved.
//

import Foundation

class FirebaseHandler: NSObject {
    
    /*
     JSON
    
    {users:
        {username: 
            {password: ...(STRING),
             trips: 
                {tripID: ...(STRING),
                    {   name: ... (STRING),
                        placeIDs: ... [array of STRING]
                    }
                }
                ... more trips
     
     
            }
        }
    }
 
    */
    
    func getUserTrips(username: String, completion: (_: [Trip]) -> Void){
        var trip: [Trip]! = []
        
        completion(trip)
    }
    
    func saveTripToFirebase(id: String, username: String, trip: Trip){
        let placeIDList: [String] = trip.placeIDs // This needs to be saved within a trip
    }
    
    func registerUser(username: String, password: String){
        
    }
    
}

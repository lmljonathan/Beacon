//
//  FirebaseHandler.swift
//  Beacon
//
//  Created by Jonathan Lam on 1/14/17.
//  Copyright © 2017 teamGo. All rights reserved.
//

import Foundation

class FirebaseHandler: NSObject {
    func getTripList(id: Int, completion: ([Business]) -> Void){
        let places: [Business] = []
        
        completion(places)
    }
    
    func getUsersTrips(userID: Int, completion: ([Trip]) -> Void){
        let trips: [Trip]! = []
        
        
        completion(trips)
    }
    
    func saveToFirebase(id: Int, trip: Trip){
        
    }
    
    
}

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
    func getPlaceIDs(tripID: Int, completion: ([Int]) -> Void){
        
        
        // completion()
        
    }
    
    func saveToFirebase(id: Int){
        let ref = FIRDatabase.database().reference(fromURL: "https://beacon-80d39.firebaseio.com/")
        let itemsRef = ref.child("trip")
        let placeRef = itemsRef.childByAutoId()
        placeRef.setValue(id)
    }
    
    
}

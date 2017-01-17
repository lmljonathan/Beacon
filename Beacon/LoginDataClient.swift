//
//  LoginDataClient.swift
//  Beacon
//
//  Created by Jonathan Lam on 1/16/17.
//  Copyright © 2017 teamGo. All rights reserved.
//

import Foundation

// Everything that interacts with data through an API or database 
// should fall in an external "client" class

class LoginDataClient {
    
    // MARK: - Perform Functions
    
    // Functions starting with "perform" have the sole purpose of
    // performing a task without mutating values. They should also
    // have a completion handler that returns nil if it is successful
    // and an NSError detailing the error if it fails.
    
    public func performLogin(completion: (_ error: NSError?) -> Void){
        completion(nil)
    }
    
    public func performSignUp(completion: (_ error: NSError?) -> Void){
        completion(nil)
    }
    
    // MARK: - Helper Functions

    
}

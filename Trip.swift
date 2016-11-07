//
//  Trip.swift
//  Beacon
//
//  Created by Kay Lab on 11/5/16.
//  Copyright © 2016 teamGo. All rights reserved.
//

import Foundation

class Trip{
    
    private var _name: String!
    private var _desc: String!
    private var _createdBy: String!
    private var _timeCreated: String!
    private var _timeUpdated: String!
    private var _priceLevel: Int!
    private var _numPlaces: Int!
    private var _numViews: Int!
    private var _placeIDs: [String]!
    
    init(name: String, desc: String, createdBy: String, timeCreated: String, timeUpdated: String, priceLevel: Int,
         numPlaces: Int, numViews: Int, placeIDs: [String]){
        self._name = name
        self._desc = desc
        self._createdBy = createdBy
        self._timeCreated = timeCreated
        self._timeUpdated = timeUpdated
        self._priceLevel = priceLevel
        self._numPlaces = numPlaces
        self._numViews = numViews
        self._placeIDs = placeIDs
        
    }
    
    var name: String {
        return self._name
    }
}

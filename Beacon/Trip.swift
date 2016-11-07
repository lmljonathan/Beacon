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
    private var _places: [Place]!
    
    init(name: String, desc: String, createdBy: String, timeCreated: String, timeUpdated: String, priceLevel: Int,
         numPlaces: Int, numViews: Int, placeIDs: [String], places: [Place]){
        self._name = name
        self._desc = desc
        self._createdBy = createdBy
        self._timeCreated = timeCreated
        self._timeUpdated = timeUpdated
        self._priceLevel = priceLevel
        self._numPlaces = numPlaces
        self._numViews = numViews
        self._placeIDs = placeIDs
        self._places = places
    }
    
    var name: String {
        return self._name
    }
    var desc: String {
        return self._desc
    }
    var createdBy: String {
        return self._createdBy
    }
    var timeCreated: String {
        return self._timeCreated
    }
    
    var timeUpdated: String {
        return self._timeUpdated
    }
    var priceLevel: Int {
        return self._priceLevel
    }
    var numPlaces: Int {
        return self._numPlaces
    }
    var numViews: Int {
        return self._numViews
    }
    var placeIDs: [String] {
        return self._placeIDs
    }
    var places: [Place] {
        return self._places
    }
    subscript(index: Int) -> String {
        return self._placeIDs[index]
    }
    
    static func ==(left: inout Trip, right: inout Trip) -> Bool{
        return (left._name == right._name && left._createdBy == right._createdBy)
    }
    
    func sortedPlaces(key:([Place]) -> Place) -> [Place]{
        return self.places.sorted(key)
    }
    
    func createRandomTrip()->Trip {
        var array: [String]
        
        for _ in 0 < 5{
            array += [randomStr(5)]
        }
        return Trip(name: randomStr(5), desc: randomStr(5), createdBy: randomStr(5), timeCreated: randomStr(5), timeUpdated: randomStr(5), priceLevel: randomInt(50), numPlaces: randomInt(50), numViews: randomInt(50), placeIDs: array, places: <#T##[Place]#>)
    }

}

func randomStr(length: Int)-> String{
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    
    var randomString = ""
    
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    
    return randomString
}

func randomInt(max: Int)-> Int{
    return arc4random_uniform(max)
}

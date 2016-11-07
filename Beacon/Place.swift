//
//  Place.swift
//  Beacon
//
//  Created by Kay Lab on 11/7/16.
//  Copyright © 2016 teamGo. All rights reserved.
//

import Foundation
import UIKit

class Place{
    
    private var _name:String!
    private var _ID:String!
    private var _address:String!
    private var _coor:(Float,Float)!
    private var _rating:Float!
    private var _isOpen:Bool!
    private var _reviews:NSArray!
    private var _phone:String!
    private var _website:String!
    private var _desc:String!

    
    init(name:String,address:String,coor:(Float,Float),ID:String,rating:Float,isOpen:Bool,reviews:NSArray, phone:String,website:String,desc:String)
    {
        self._name = name
        self._address = address
        self._coor = coor
        self._rating = rating
        self._isOpen = isOpen
        self._reviews = reviews
        self._phone = phone
        self._website = website
        self._desc = desc
    }
    
    var getName:String{
        return self._name
    }
    
    var getID:String{
        return self._ID
    }
    
    var getAddress:String{
        return self._address
    }
    
    var getCoor:(Float,Float){
        return self._coor
    }
    
    var getRating:Float{
        return self._rating
    }
    
    var isOpen:Bool{
        return self._isOpen
    }
    
    var getReviews:NSArray{
        return self._reviews
    }
    
    var getPhone:String{
        return self._phone
    }
    
    var getWebsite:String{
        return self._website
    }
    
    var getDesc:String{
        return self._desc
    }
    
    static func ==(left: Place, right: Place) -> Bool{
        return left._ID == right._ID
    }
    
}

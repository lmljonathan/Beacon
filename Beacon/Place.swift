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
    private var _id:String!
    private var _address:String!
    private var _coor:(Float,Float)!
    private var _rating:Float!
    private var _isOpen:Bool!
    private var _reviews:NSArray!
    private var _phone:String!
    private var _website:String!
    private var _desc:String!

    
    init(id: String, name: String, address: String, coor: (Float,Float), rating:Float, isOpen: Bool, reviews: NSArray, phone:String, website:String, desc:String)
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
    
    init(){
        
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
        print("hello")
        return left._id == right._id
    }
    
}


struct GooglePlaceDetail {
    var name: String! = ""
    var address: String! = ""
    var formattedAddress: String! = ""
    var phone: String! = ""
    var website: String! = ""
    var hours: NSMutableArray! = []
    var priceRating: Int! = 0
    var rating: Double! = 0
    var reviews: NSMutableArray! = []
    var photos: NSMutableArray! = []
    var types: NSMutableArray! = []
    var status: Bool! = nil
    
    var longitude: Double! = -1 //
    var latitude: Double! = -1 //
    
    func convertToPlace() -> Place{
        // var place = Place(id: <#T##String#>, name: <#T##String#>, address: <#T##String#>, coor: <#T##(Float, Float)#>, rating: <#T##Float#>, isOpen: <#T##Bool#>, reviews: <#T##NSArray#>, phone: <#T##String#>, website: <#T##String#>, desc: <#T##String#>)
//        var business = Place()
//        business.businessName = self.name
//        business.businessAddress = self.address
//        business.businessLatitude = self.latitude
//        business.businessLongitude = self.longitude
//        business.businessName = self.name
//        business.businessAddress = self.address
//        business.businessPhone = self.phone
//        business.businessRating = self.rating
//        business.businessStatus = self.status
//        
//        if self.photos.count > 0 {
//            business.businessPhotoReference = self.photos[0] as! String
//        }
//        business.businessTypes = self.types
        
        return business
    }
}


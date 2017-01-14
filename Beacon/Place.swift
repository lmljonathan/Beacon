//
//  Place.swift
//  Beacon
//
//  Created by Kay Lab on 11/7/16.
//  Copyright © 2016 teamGo. All rights reserved.
//

import Foundation
import UIKit

struct Place{
    
    var name: String! = ""
    var id: String! = ""
    var address: String! = ""
    var coor: (Float,Float)! = (0, 0)
    var rating: Float! = 0
    var isOpen: Bool! = false
    var reviews: NSMutableArray = []
    var phone: String! = ""
    var website: String! = ""
    var desc: String! =  ""
    var photoReference: String! = ""
    var photos: NSMutableArray! = []
    
//    init(id: String, name: String, address: String, coor: (Float,Float), rating:Float, isOpen: Bool, reviews: NSArray, phone:String, website:String, desc:String)
//    {
//        self._name = name
//        self._address = address
//        self._coor = coor
//        self._rating = rating
//        self._isOpen = isOpen
//        self._reviews = reviews
//        self._phone = phone
//        self._website = website
//        self._desc = desc
//    }
    
//    var getName:String{
//        return self._name
//    }
//    
//    var getID:String{
//        return self._ID
//    }
//    
//    var getAddress:String{
//        return self._address
//    }
//    
//    var getCoor:(Float,Float){
//        return self._coor
//    }
//    
//    var getRating:Float{
//        return self._rating
//    }
//    
//    var isOpen:Bool{
//        return self._isOpen
//    }
//    
//    var getReviews:NSArray{
//        return self._reviews
//    }
//    
//    var getPhone:String{
//        return self._phone
//    }
//    
//    var getWebsite:String{
//        return self._website
//    }
//    
//    var getDesc:String{
//        return self._desc
//    }
    
//    var getName:String{
//        return self._name
//    }
//    
//    var getID:String{
//        return self._id
//    }
//    
//    var getAddress:String{
//        return self._address
//    }
//    
//    var getCoor:(Float,Float){
//        return self._coor
//    }
//    
//    var getRating:Float{
//        return self._rating
//    }
//    
//    var isOpen:Bool{
//        return self._isOpen
//    }
//    
//    var getReviews:NSArray{
//        return self._reviews
//    }
//    
//    var getPhone:String{
//        return self._phone
//    }
//    
//    var getWebsite:String{
//        return self._website
//    }
//    
//    var getDesc:String{
//        return self._desc
//    }
    
    static func ==(left: Place, right: Place) -> Bool{
        print("hello")
        return left.id == right.id
    }
    
}


struct GooglePlaceDetail {
    
    var id: String! = ""
    var isOpen:Bool = true
    var desc:String! = ""
    var name: String! = ""
    var coor: (Float, Float) = (0.0, 0.0)
    var address: String! = ""
    var formattedAddress: String! = ""
    var phone: String! = ""
    var website: String! = ""
    var hours: NSMutableArray! = []
    var priceRating: Int! = 0
    var rating: Float! = 0
    var reviews: NSMutableArray! = []
    var photos: NSMutableArray! = []
    var types: NSMutableArray! = []
    var status: Bool! = nil
    var photoReference: String! = ""
    var longitude: Double! = -1 //
    var latitude: Double! = -1 //
    
    func convertToPlace() -> Place{
        var place = Place(name: name, id: id, address: address, coor: coor, rating: rating, isOpen: isOpen, reviews: reviews, phone: phone, website: website, desc: desc, photoReference: photoReference, photos: photos)
        
        print("FROM CONVERTTOPLACE:", place.photoReference)
        
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
        
        return place
    }
}


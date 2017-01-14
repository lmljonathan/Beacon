//: Playground - noun: a place where people can play

import UIKit


struct Review{
    var name: String!
    var text: String!
}

struct Place{
    var name: String!
    var isOpen: Bool!
    var rating: Double!
    var reviews: [Review]!
    
    var description: String {
        return ("\(Place.dynamicType)")
    }
}

//struct Trip {
//    var places: [Place]!
//}

let data = ["results": ["places": ["reviews": []]]]


// Final Result

func getPlaceFromData(data: [Hashable], completion: (_ place: Place) -> Void){
    let place = Place()
    place.
}

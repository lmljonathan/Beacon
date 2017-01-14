//
//  DataHelper.swift
//  Beacon
//
//  Created by Jonathan Lam on 1/14/17.
//  Copyright © 2017 teamGo. All rights reserved.
//

import Foundation

extension ListViewController{
    
    func loadData(){
        fbClient.getPlaceIDs(tripID: 000) { (places) in
            for id in places{
                self.apiClient.getPlaceDetailed(id: id, completion: { (detailedPlace) in
                    let place = detailedPlace.convertToPlace()
                    updateWithPlace(place)
                })
            }
        }

    }
    
    func updateWithPlace(_ place: Place){
        self.trip.append(place)
    }
    
    // Private functions
}

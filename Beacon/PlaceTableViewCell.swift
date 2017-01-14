//
//  PlaceTableViewCell.swift
//  Yelpify
//
//  Created by Jonathan Lam on 2/17/16.
//  Copyright © 2016 Yelpify. All rights reserved.
//

import UIKit
import Cosmos
import MGSwipeTableCell
import Kingfisher

class PlaceTableViewCell: MGSwipeTableCell {
    
    enum cellMode {
        case add, more
    }
    
    @IBOutlet weak var ratingView: CosmosView!
  
//    let cache = Shared.imageCache
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var placeTitleLabel: UILabel!
    
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var businessBackgroundImage: UIImageView!
    
    @IBOutlet weak var businessAddressLabel: UILabel!
    @IBOutlet weak var businessOpenLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var actionButtonView: UIView!
    
    override func draw(_ rect: CGRect) {
        mainView.addShadow(4, opacity: 0.2, offset: CGSize(width: 0, height: 4), path: true)
    }
    
    func loadData(id: String, completion: (Place) -> Void){
        let apiClient = APIDataHandler()
        apiClient.performDetailedSearch(id, completion: { (detailedPlace) in
            let place = detailedPlace.convertToPlace()
            print("PHOTOREFERENCE",place.photoReference)
            DispatchQueue.main.async {
                self.configure(with: place, mode: .more, completion: {
                    print("CONFIGURING")
                    func buildPlacePhotoURLString(_ photoReference: String) -> String{
                        let photoParameters = [
                            "key" : "AIzaSyDkxzICx5QqztP8ARvq9z0DxNOF_1Em8Qc",
                            "photoreference" : photoReference,
                            "maxheight" : "800"
                        ]
                        var result = "https://maps.googleapis.com/maps/api/place/photo?"
                        for (key, value) in photoParameters{
                            let addString = key + "=" + value + "&"
                            result += addString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                        }
                        return result
                    }
                    print(place.photoReference)
                    if place.photoReference != ""{
                        print("THERE IS A PHOTO")
                        let PhotoURL = buildPlacePhotoURLString(place.photoReference)
                        let URL = Foundation.URL(string:PhotoURL)!
                        
                        self.businessBackgroundImage.kf.setImage(with: URL)
                    }
                    
                })
            }
            
        })
    }
    
    func configure(with place: Place, mode: cellMode, completion:() -> Void){
        switch mode {
        case .add:
            self.configureButton(UIImage())
            let tapRec = UITapGestureRecognizer(target: self, action: #selector(self.actionButtonPressed(_:)))
            actionButtonView.addGestureRecognizer(tapRec)

        case .more:
            self.configureButton(UIImage())
            self.moreButton.isHidden = true
        default:
            self.configureButton(UIImage())
        }
        
        //Set Icon
        let businessList = ["restaurant","food","amusement","bakery","bar","beauty_salon","bowling_alley","cafe","car_rental","car_repair","clothing_store","department_store","grocery_or_supermarket","gym","hospital","liquor_store","lodging","meal_takeaway","movie_theater","night_club","police","shopping_mall"]
        
//        if place.businessTypes.count != 0 && businessList.contains(String(describing: place.businessTypes[0])){
//            categoryIcon.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
//            let origImage = UIImage(named: String(describing: place.businessTypes[0]) + "_Icon")!
//            let tintedImage = origImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
//            categoryIcon.image = tintedImage
//            categoryIcon.tintColor = appDefaults.color_darker
//            
//        }else{
//            categoryIcon.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
//            let origImage = UIImage(named: "default_Icon")!
//            let tintedImage = origImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
//            categoryIcon.image = tintedImage
//            categoryIcon.tintColor = appDefaults.color_darker
//        }
//        
        // Set Name
        placeTitleLabel.text = place.name
        
        // Set Address
        businessAddressLabel.text = place.address
        
        // Set Rating
        //print("\(business.businessName): \(business.businessRating)")
        if place.rating != -1{
            self.ratingView.isHidden = false
            if let ratingValue2 = place.rating{
                self.ratingView.rating = Double(ratingValue2)
            }
        }else{
            self.ratingView.isHidden = true
        }
        
        // Set Status
        if place.isOpen != nil{
            if place.isOpen == true{
                businessOpenLabel.text = "Open Now"
            }else{
                businessOpenLabel.text = "Closed"
            }
        }else{
            businessOpenLabel.text = "No Hours Availible"
        }
        
//        // Set Background Image
        self.businessBackgroundImage.backgroundColor = appDefaults.color
        self.businessBackgroundImage.image = nil
        
        func buildPlacePhotoURLString(_ photoReference: String) -> String{
            let photoParameters = [
                "key" : "AIzaSyDkxzICx5QqztP8ARvq9z0DxNOF_1Em8Qc",
                "photoreference" : photoReference,
                "maxheight" : "800"
            ]
            var result = "https://maps.googleapis.com/maps/api/place/photo?"
            for (key, value) in photoParameters{
                let addString = key + "=" + value + "&"
                result += addString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            }
            return result
        }
        
        if place.photoReference != ""{
            let PhotoURL = buildPlacePhotoURLString(place.photoReference)
            //let URLString = self.items[indexPath.row]
            let URL = Foundation.URL(string:PhotoURL)!
            //businessBackgroundImage.hnk_setImageFromURL(URL: URL as NSURL)
            //let url = URL(string: "https://domain.com/image.jpg")!
            businessBackgroundImage.kf.setImage(with: URL)
        }
        else{
            businessBackgroundImage.image =  UIImage(named: "default_business_bg")
            
        }
    }
    

    func configureButton(_ image: UIImage){
        //let tintedImage = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        if actionButton != nil{
            //self.actionButton.setImage(tintedImage, forState: .Normal)
            self.actionButton.tintColor = appDefaults.color_darker
        }
    }
    
    func changeImageViewColor(_ imageView: UIImageView, color: UIColor) {
        
    }
    
//    func addShadow(){
//        self.mainView.layer.shadowColor = UIColor.blackColor().CGColor
//        self.mainView.layer.shadowOpacity = 0.2
//        self.mainView.layer.shadowOffset = CGSize(width: 0, height: 4)
//        self.mainView.layer.shadowRadius = 4
//    }
//    
    
    @IBAction func actionButtonPressed(_ sender: AnyObject) {
        self.actionButton.tintColor = UIColor.green
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

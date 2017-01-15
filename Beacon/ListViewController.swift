//
//  ListViewController.swift
//  Lyster
//
//  Created by Jonathan Lam on 8/25/16.
//  Copyright © 2016 Limitless. All rights reserved.
//

import UIKit
import MapKit
import MGSwipeTableCell
import XLActionController
import CZPicker

class ListViewController: UIViewController {
    
    enum ListMode{
        case view, edit
    }
    
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var indicatorView: UIView!
    @IBOutlet var pullDownBar: UIView!
    
    @IBOutlet var bannerView: UIView!
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var citiesLabel: UILabel!
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var listTableView: UITableView!
    
    @IBOutlet var addPlaceButton: UIButton!
    
    @IBAction func moreButtonPressed(_ sender: Any) {
        self.showActionsMenu()
    }
    
    // @IBOutlet var bottomViewHeight: NSLayoutConstraint!
    
    
    let topMapProportion: CGFloat = 1/5
    let bottomMapProportion: CGFloat = 7/10
    
    var itemReceived: Array<AnyObject> = []
    var sortMethod:String!
    
    var playlist_swiped: String!
    
    var gPlaceArray: [GooglePlaceDetail] = []
    var placeArray: [Place] = []
    
    var placeIDs: [String] = []
    
    
    // Clients
    var apiClient = APIDataHandler()
    let fbClient = FirebaseHandler()
    
    let imagePicker = UIImagePickerController()
    
    var mode: ListMode! = .view
    var mapScroll: Bool! = false
    
     var originalFrame: CGRect!
    
    
//    @IBAction func unwindToSinglePlaylist(_ segue: UIStoryboardSegue)
//    {
//        print(segue.identifier)
//        if(segue.identifier != nil) {
//            if(segue.identifier == "unwindToPlaylist") {
//                if let sourceVC = segue.source as? SearchBusinessViewController
//                {
//                    playlistArray.append(contentsOf: sourceVC.businessArray)
//                    placeIDs.append(contentsOf: sourceVC.placeIDs)
//                    
//                    // Appends empty GooglePlaceDetail Objects to make list parallel to placeIDs and playlistArray
//                    for _ in 0..<(placeIDs.count - placeArray.count){
//                        placeArray.append(GooglePlaceDetail())
//                    }
//                    
//                    // Update Info
//                    //                    self.numOfPlacesLabel.text = "\(placeIDs.count)"
//                    //                    self.getAveragePrice({ (avg) in
//                    //                        self.setPriceRating(avg)
//                    //                    })
//                    self.listTableView.reloadData()
//                }
//            }
//        }
//    }
    
    
//    @IBAction func pressedAddPlacesButton(_ sender: AnyObject) {
//        performSegue(withIdentifier: "tapImageButton", sender: self)
//    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        self.navigationController?.resetTopBars(0)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRecognizers()
        
        // Register Nibs
        self.listTableView.register(UINib(nibName: "PlaceCell", bundle: .main), forCellReuseIdentifier: "placeCell")
        
        // CHANGE
        let googleParameters = ["key": "AIzaSyCwz0NEe0TCqASETjbnWQNqbdQkwMIbmFo", "location": "33.672354,-117.798607", "rankby": "distance", "keyword": "food"]
        apiClient.performAPISearch(googleParameters) { (results) in
            self.placeIDs = results.map({$0.id})
            self.loadData()
        }
        
        self.mapView.delegate = self
        self.bannerView.addShadow()
        self.addPlaceButton.addShadow()
        self.bottomView.addShadow()
        self.indicatorView.addShadow(opacity: 0.2, offset: CGSize(width: 0, height: 5))
        self.indicatorView.hideShadow()
        self.pullDownBar.layer.cornerRadius = 3
        self.pullDownBar.addShadow()
    
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
//        let rightButton = UIBarButtonItem(image: UIImage(named: "more_icon"), style: .plain, target: self, action: #selector(self.showActionsMenu(_:)))
//        navigationItem.rightBarButtonItem = rightButton
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.bottomView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func loadData(){
        func getCities(){
            let coordArray = self.gPlaceArray.map({CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)})
            self.mapView.getCitiesFromCoordinates(coordArray) { (cities) in
                let sortedCities = cities.sorted(by: {$0 < $1})
                let numPlacesString = String(self.placeIDs.count) + " Places near "
                let citiesString = sortedCities.map({$0.0}).joined(separator: ", ")
                
                let resultString = numPlacesString + citiesString
                self.citiesLabel.fadeIn(resultString, beginScale: 1)
            }
        }
        
        func updateBusinessesFromIDs(_ ids: [String], reloadIndex: Int = 0){
            if ids.count > 0{
                apiClient.performDetailedSearch(ids[0]) { (detailedGPlace) in
                    self.mapView.addMarker(detailedGPlace.latitude, long: detailedGPlace.longitude, title: detailedGPlace.name, row: reloadIndex)
                    
                    self.gPlaceArray[reloadIndex] = detailedGPlace
                    self.placeArray[reloadIndex] = detailedGPlace.convertToPlace()
                    
                    if reloadIndex == self.placeArray.count - 1 {
                        self.mapView.initializeMap()
                        getCities()
                    }
                    
                    let idsSlice = Array(ids[1..<ids.count])
                    let index = IndexPath(row: reloadIndex, section: 0)
                    self.listTableView.reloadRows(at: [index], with: .fade) // CHANGE
                    let newIndex = reloadIndex + 1
                    updateBusinessesFromIDs(idsSlice, reloadIndex: newIndex)
                }
            }
        }
        
        DispatchQueue.main.async{
            self.configureHeader()
            for _ in 0..<self.placeIDs.count{
                self.gPlaceArray.append(GooglePlaceDetail())
                self.placeArray.append(Place())
            }
            
            DispatchQueue.main.async{
                self.listTableView.reloadData()
                
                DispatchQueue.main.async{
                    updateBusinessesFromIDs(self.placeIDs)
                }
            }
        }
        
//        Async.main{
//            let placeIDs = self.object["place_id_list"] as! [String]
//            self.placeIDs = placeIDs
//            self.configureHeader()
//            }.main{
//                // Get Array of IDs from Parse
//                for _ in 0..<self.placeIDs.count{
//                    self.placeArray.append(GooglePlaceDetail())
//                    self.playlistArray.append(Business())
//                }
//                self.listTableView.reloadData()
//            }.main{
//                updateBusinessesFromIDs(self.placeIDs)
//        }
    }
    
    // MARK: - Set Up Header View With Info
    func configureHeader() {
        
        let pushAlpha: Double = 1.0
        let pushDuration: Double = 0.7
        let pushBeginScale: CGFloat = 1.0
        let pushAllScale: CGFloat = 1.1
        
        // Set List Name
        //if let name = object["playlistName"] as? String{
            self.titleTextField.fadeIn("SF Adventures", duration: pushDuration, beginScale: pushBeginScale)
        // }
    
        self.bannerImageView.fadeIn(UIImage(named: "sf")!, endAlpha: 0.5, beginScale: 1.2)
        
    }
    
    //    func configureReorderControl(){
    //        self.reorderControlHandler = ReorderControl(tableView: self.listTableView, arrayToReorder: self.trip, outerView: self.view)
    //    }
    
    
    func activateEditMode() {
        
        //configureReorderControl()
        
        // Make Title Text Editable
        self.titleTextField.enable()
        self.titleTextField.delegate = self
        
        // Show Change BG Image Button
        //self.changePlaylistImageButton.hidden = false
        
        // Replace More Button With Cancel Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.deactivateEditMode))
        
        // Animate and Show Add Place Button
        self.addPlaceButton.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState,animations: {
            self.addPlaceButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)},
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.6){self.addPlaceButton.transform = CGAffineTransform.identity}
        })
        
        // Set Editing to True
        self.listTableView.setEditing(true, animated: true)
        let bottomPanGR = self.bottomView.gestureRecognizers![1] as! UIPanGestureRecognizer
        self.bottomView.removeGestureRecognizer(bottomPanGR)
        
        // Set Edit Mode
        self.mode = .edit
        
//        // Replace Back Button with Done
//        self.navigationItem.setHidesBackButton(true, animated: true)
//        let backButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.savePlaylistToParse(_:)))
//        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func deactivateEditMode() {
        
        // Make Title Text Editable
        self.titleTextField.disable()
        self.titleTextField.delegate = nil
        
        // Hide Change BG Image Button
        //self.changePlaylistImageButton.hidden = true
        
//        // Restore More Icon to Right Side of Nav Bar
//        let rightButton = UIBarButtonItem(image: UIImage(named: "more_icon"), style: .plain, target: self, action: #selector(self.showActionsMenu(_:)))
//        navigationItem.rightBarButtonItem = rightButton
        
        // Restore Back Button
        self.navigationItem.setHidesBackButton(false, animated: true)
        self.navigationItem.leftBarButtonItem = nil
        
        // Set Editing to False
        self.listTableView.setEditing(false, animated: true)
        // self.addPanGR()
        
        // Hide Add Place Button
        self.addPlaceButton.isHidden = true
        // Change to View Mode
        self.mode = .view
    }
    
    func configureSwipeButtons(_ cell: MGSwipeTableCell, mode: ListMode){
        if mode == .view{
            let routeButton = MGSwipeButton(title: "ROUTE", icon: UIImage().imageWithColor(appDefaults.color),backgroundColor: UIColor.clear, padding: 25)
            routeButton.setEdgeInsets(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0))
            routeButton.centerIconOverText()
            routeButton.titleLabel?.font = appDefaults.font
            routeButton.titleLabel?.textColor = appDefaults.color
            
            let addButton = MGSwipeButton(title: "ADD", icon: UIImage().imageWithColor(appDefaults.color) ,backgroundColor: UIColor.clear, padding: 25)
            addButton.setEdgeInsets(UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 15))
            addButton.centerIconOverText()
            addButton.titleLabel?.font = appDefaults.font
            addButton.titleLabel?.textColor = appDefaults.color
            
            cell.rightButtons = [addButton]
            cell.rightSwipeSettings.transition = MGSwipeTransition.clipCenter
            cell.rightExpansion.buttonIndex = 0
            cell.rightExpansion.fillOnTrigger = false
            cell.rightExpansion.threshold = 1
            
            cell.leftButtons = [routeButton]
            cell.leftSwipeSettings.transition = MGSwipeTransition.clipCenter
            cell.leftExpansion.buttonIndex = 0
            cell.leftExpansion.fillOnTrigger = true
            cell.leftExpansion.threshold = 1
            
        }else if mode == .edit{
            cell.rightButtons.removeAll()
            cell.leftButtons.removeAll()
            let deleteButton = MGSwipeButton(title: "Delete",icon: UIImage(),backgroundColor: UIColor.red,padding: 25)
            deleteButton.centerIconOverText()
            cell.leftButtons = [deleteButton]
            cell.leftSwipeSettings.transition = MGSwipeTransition.clipCenter
            cell.leftExpansion.buttonIndex = 0
            cell.leftExpansion.fillOnTrigger = true
            cell.leftExpansion.threshold = 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showBusinessDetail"){
            let upcoming: BusinessDetailViewController = segue.destination as! BusinessDetailViewController
            
            let index = (listTableView.indexPathForSelectedRow! as NSIndexPath).row
            print(index)
            
            // IF NO NEW PLACE IS ADDED
            if placeArray[index].name != ""{
                let gPlaceObject = gPlaceArray[index]
                upcoming.gPlaceObject = gPlaceObject
                upcoming.index = index
            }else{
                // IF NEW PLACES ARE ADDED
                let businessObject = self.placeArray[index]
                upcoming.object = businessObject
                upcoming.index = index
            }
            
            self.listTableView.deselectRow(at: listTableView.indexPathForSelectedRow!, animated: true)}
//        }else if (segue.identifier == "tapImageButton"){
//            let nav = segue.destination as! UINavigationController
//            let upcoming = nav.childViewControllers[0] as! SearchBusinessViewController
//            upcoming.currentView = .addPlace
//            upcoming.searchTextField = upcoming.addPlaceSearchTextField        }
    }
//    
//    func getIDsFromArrayOfBusiness(_ business: [Place], completion: (_ result:[String])->Void){
//        var result:[String] = []
//        for b in business{
//            result.append(b.gPlaceID)
//        }
//        completion(result)
//    }
//    
//    func sortMethods(_ businesses: Array<Business>, type: String)->[Business]{
//        var sortedBusinesses: Array<Business> = []
//        if type == "name"{
//            sortedBusinesses = businesses.sorted{$0.businessName < $1.businessName}
//        } else if type == "rating"{
//            sortedBusinesses = businesses.sorted{$0.businessRating > $1.businessRating}
//        }
//        return sortedBusinesses
//    }
//    
//    func sortGooglePlaces(_ gPlaces: [GooglePlaceDetail],type:String) -> [GooglePlaceDetail]{
//        var sortedBusinesses: Array<GooglePlaceDetail> = []
//        if type == "name"{
//            sortedBusinesses = gPlaces.sorted{$0.name < $1.name}
//        } else if type == "rating"{
//            sortedBusinesses = gPlaces.sorted{$0.rating > $1.rating}
//        }
//        return sortedBusinesses
//        
//    }
}


extension ListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0{
            self.indicatorView.showShadow(0.2)
        }else{
            self.indicatorView.hideShadow()
        }
        
    }
    
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        self.indicatorView.hideShadow()
    }
    
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if mapScroll == true{
            self.indicatorView.hideShadow()
            self.mapScroll = false
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < 0{
            self.indicatorView.hideShadow()
        }
    }
}

extension ListViewController: MKMapViewDelegate{
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "annotation")
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.listTableView.scrollToRow(at: IndexPath(row: (view.annotation!.cellRow)!, section: 0), at: .top, animated: true)
        self.mapScroll = true
    }
}

extension ListViewController: UIGestureRecognizerDelegate{
    //    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
    //        if gestureRecognizer is UITapGestureRecognizer {
    //            let location = touch.locationInView(self.listTableView)
    //            return (self.listTableView.indexPathForRowAtPoint(location) == nil)
    //        }
    //        return true
    //    }
}

extension ListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

extension ListViewController {//: ModalViewControllerDelegate{
    
//    func sendValue(_ value: AnyObject){
//        itemReceived.append(value as! NSObject)
//        
//        for item in itemReceived{
//            if (item as! NSObject) as! String == "Alphabetical"{
//                self.trip = self.sortMethods(self.trip, type: "name")
//                getIDsFromArrayOfBusiness(self.trip, completion: { (result) in
//                    self.placeIDs = result
//                    self.placeArray = self.sortGooglePlaces(self.placeArray, type: "name")
//                    print("sorting")
//                    self.listTableView.reloadData()
//                })
//            }else if (item as! NSObject) as! String == "Rating"{
//                self.trip = self.sortMethods(self.trip, type: "rating")
//                getIDsFromArrayOfBusiness(self.trip, completion: { (result) in
//                    self.placeIDs = result
//                    self.placeArray = self.sortGooglePlaces(self.placeArray, type: "rating")
//                    self.listTableView.reloadData()
//                })
//                
//            }
//            else {
//                let index = item as! Int
//                var playlist = addToOwnPlaylists[index]["place_id_list"] as! [String]
//                print(playlist)
//                playlist.append(self.playlist_swiped)
//                print(playlist)
//                
//                addToOwnPlaylists[index]["num_places"] = playlist.count
//                addToOwnPlaylists[index]["place_id_list"] = playlist
//                addToOwnPlaylists[index].saveInBackground(block: { (success, error) in
//                    if (error == nil) {
//                        print("Saved")
//                    }
//                })
//            }
//            itemReceived = []
//        }
//        
//        
//    }
    
    func showActionsMenu() {
        let actionController = YoutubeActionController()
        // let pickerController = CZPickerViewController()
        //let randomController = RandomPlaceController()
        
        //        actionController.addAction(Action(ActionData(title: "Randomize", image: UIImage(named: "action_random")!), style: .Default, handler: { action in
        //            if self.trip.count != 0{
        //                self.performSegueWithIdentifier("randomPlace", sender: self)
        //            }
        //
        //        }))
        actionController.addAction(Action(ActionData(title: "Edit", image: UIImage()), style: .default, handler: { action in
            print("Edit pressed")
            self.activateEditMode()
            self.listTableView.reloadData()
        }))
        //        actionController.addAction(Action(ActionData(title: "Make Collaborative", image: UIImage(named: "action_collab")!), style: .Default, handler: { action in
        //            self.makeCollaborative()
        //        }))
//        actionController.addAction(Action(ActionData(title: "Sort", image: UIImage(named: "action_sort")!), style: .cancel, handler: { action in
//            pickerController.headerTitle = "Sort Options"
//            pickerController.fruits = ["Alphabetical","Rating"]
//            pickerController.showWithFooter(UIViewController.self)
//            pickerController.delegate = self
//        }))
        actionController.addAction(Action(ActionData(title: "Cancel", image: UIImage(named: "yt-cancel-icon")!), style: .cancel, handler: nil))
        
        present(actionController, animated: true, completion: nil)
    }
}


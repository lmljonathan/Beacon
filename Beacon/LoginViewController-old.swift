////
////  loginViewController.swift
////  Beacon
////
////  Created by Kenny Nguyen on 1/14/17.
////  Copyright © 2017 teamGo. All rights reserved.
////
//
//import UIKit
//import FirebaseAuth
//import FirebaseDatabase
//
//
//class LoginViewController-old: UIViewController, UITextFieldDelegate {
//    
//    //    let loginButton: FBSDKLoginButton = {
//    //        let button = FBSDKLoginButton()
//    //        button.readPermissions = ["email"]
//    //        return button
//    //    }()
//    
//    
//    @IBOutlet weak var usernameField: UITextField!
//    @IBOutlet weak var passwordField: UITextField!
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //self.usernameField.delegate = self
//        //self.passwordField.delegate = self
//        // let ref = FIRDatabase.database().reference(fromURL: "https://beacon-80d39.firebaseio.com/")
//        let ref = FIRDatabase.database().reference(withPath: "trips")
//        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
//            if user != nil {
//                self.performSegue(withIdentifier: "loginSuccess", sender: nil)
//                let exTrip = Trip(id: "adsfs", name: "sdfd", placeIDs: ["sdfa","safe", "sdafds"])
//                let test = FirebaseHandler()
//                test.saveTripToDataBase(trip: exTrip)
//                test.retrieveTripDetails(completion: { (tripArray) in
//                    for trip in tripArray {
//                        print("->", trip.name)
//                    }
//                })
//                ref.child("places").observeSingleEvent(of: .value, with: { (snapshot) in
//                    let value = snapshot.value as? NSDictionary
//                    print("GGGGGGGG",value)
//                })
//                
//                
//            }
//            
//                
//            
//        }
//    }
//    
//    @IBAction func login(_ sender: Any){
//        FIRAuth.auth()!.signIn(withEmail: usernameField.text!,
//                               password: passwordField.text!)
//    }
//    
//    @IBAction func signup(_ sender: Any){
//        
//        let alert = UIAlertController(title: "Register",
//                                      message: "Register",
//                                      preferredStyle: .alert)
//        
//        let saveAction = UIAlertAction(title: "Save",
//                                       style: .default) { action in
//                                        let emailField = alert.textFields![0]
//                                        let passwordField = alert.textFields![1]
//                                        
//                                        FIRAuth.auth()!.createUser(withEmail: emailField.text!,
//                                                                   password: passwordField.text!, completion: {(user, error) in
//                                                                    if error == nil {
//                                                                        FIRAuth.auth()!.signIn(withEmail: self.usernameField.text!,
//                                                                                               password: self.passwordField.text!)
//                                                                    }
//                                        })
//        }
//        
//        let cancelAction = UIAlertAction(title: "Cancel",
//                                         style: .default)
//        
//        alert.addTextField { textEmail in
//            textEmail.placeholder = "Enter your email"
//        }
//        
//        alert.addTextField { textPassword in
//            textPassword.isSecureTextEntry = true
//            textPassword.placeholder = "Enter your password"
//        }
//        
//        alert.addAction(saveAction)
//        alert.addAction(cancelAction)
//        
//        present(alert, animated: true, completion: nil)
//    }
//
//        
//    override func viewDidAppear(_ animated: Bool) {
//        
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {   //delegate method
//        textField.resignFirstResponder()
////        if textField == usernameField{
////            self.fadeNewImage(self.usernameBG, newImage: UIImage(named: "text_field_white")!)
////        }else{
////            self.fadeNewImage(self.passwordBG, newImage: UIImage(named: "text_field_white")!)
////        }
//        return true
//    }
//    
////    @IBAction func usernameFieldDidBeginEditing(_ sender: AnyObject) {
////        self.fadeNewImage(self.usernameBG, newImage: UIImage(named: "text_field_grey")!)
////    }
////    
////    @IBAction func passwordFieldDidBeginEditing(_ sender: AnyObject) {
////        self.fadeNewImage(self.passwordBG, newImage: UIImage(named: "text_field_grey")!)
////    }
//    
//    func fadeNewImage(_ imageView: UIImageView, newImage: UIImage){
//        func fadeInImage(_ image: UIImageView){
//            UIImageView.animate(withDuration: 0.5, animations: {
//                image.alpha = 1
//            })
//        }
//        
//        func fadeOutImage(_ image: UIImageView){
//            UIImageView.animate(withDuration: 0.5, animations: {
//                image.alpha = 0
//            })
//        }
//        
//        fadeOutImage(imageView)
//        imageView.image = newImage
//        fadeInImage(imageView)
//    }
//    
//    
//    
//    
//
//    
//    @IBAction func loginAction(_ sender: UIButton) {
//        let username = self.usernameField.text!
//        let password = self.passwordField.text!
//        
////        if (!username.isEmpty && !password.isEmpty)
////        {
////            
////            print("hello")
////            
////            PFUser.logInWithUsername(inBackground: username, password: password, block: { (user, error) in
////                if (error == nil)
////                {
////                    if (user != nil)
////                    {
////                        print("success")
////                        self.performSegue(withIdentifier: "loginSuccessSegue", sender: self)
////                    }
////                    else if (user == nil){
////                        self.AnimationShakeTextField(self.usernameField)
////                        self.AnimationShakeTextField(self.passwordField)
////                    }
////                }
////            })
////        }
////        else{
////            AnimationShakeTextField(usernameField)
////            AnimationShakeTextField(passwordField)
////        }
//    }
//    func AnimationShakeTextField(_ textField:UITextField){
//        let animation = CABasicAnimation(keyPath: "position")
//        animation.duration = 0.07
//        animation.repeatCount = 4
//        animation.autoreverses = true
//        animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 5, y: textField.center.y))
//        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 5, y: textField.center.y))
//        textField.layer.add(animation, forKey: "position")
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    override var shouldAutorotate : Bool {
//        return false
//    }
//    
//    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
//        return UIInterfaceOrientationMask.portrait
//    }
//    
//    
//}
//
//

//
//  LoginViewController.swift
//  Beacon
//
//  Created by Jonathan Lam on 1/16/17.
//  Copyright © 2017 teamGo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Unwind Functions
    @IBAction func unwindToLogin(_ segue: UIStoryboardSegue) {
        
    }
    
    // MARK: - Layout (IBOutlets)
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - Private Variables
    private let client = LoginDataClient() // The first variable in the private variables should always be the client
    
    // MARK: - Segue Identifiers
    private let signUpIdentifier = ""
    private let homeIdentifier = ""
    
    // MARK: - IBActions
    @IBAction func loginButtonPressed(_ sender: AnyObject) {
        client.performLogin { (error) in
            if error == nil{
                // Do something if perform login is successful (like segueing to next VC)
                
            }else{
                print(error)
            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: AnyObject) {
        // segue to signUpVC
        performSegue(withIdentifier: signUpIdentifier, sender: nil)
    }
    
    
    // MARK: - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Delegates
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
}

// Delegate functions should fall under new extensions
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Do something when user presses return
    }
    
}

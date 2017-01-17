//
//  SignUpViewController.swift
//  Beacon
//
//  Created by Jonathan Lam on 1/16/17.
//  Copyright © 2017 teamGo. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - Layout (IBOutlets)
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - IBActions
    
    
    // MARK: - Private Variables
    let client: LoginDataClient! = LoginDataClient()
    
    
    // MARK: - Public Variables
    
    
    // MARK: - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//
//  LoginViewController.swift
//  SmartNeighborhood
//
//  Created by Amanda Rawls on 10/13/17.
//  Copyright © 2017 Amanda Rawls. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    var user: String?
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var tappableBackgroundView: UIView!
    @IBOutlet weak var fbLoginContainer: UIView!
    
    // MARK: - View Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        passwordTextField.delegate = self
        configureTappableBackground()
        configureFacebookLogin()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(#function)
        super.prepare(for: segue, sender: sender)
        
        if let name = user, let navControl = segue.destination as? UINavigationController,
            let vc = navControl.topViewController as? HomeViewController {
            vc.model = UserModel(user: name)
            nameTextField.text = ""
            nameTextField.placeholder = "name"
            passwordTextField.text = ""
            passwordTextField.placeholder = "password"
        }
    }

    // MARK: - IBActions
    @IBAction func LoginButtonPressed(_ sender: UIButton) {
        validateUser()
    }
    
    // MARK: - Methods
    func configureFacebookLogin() {
        // check for existing log in
        if (FBSDKAccessToken.current() != nil) {
            validateUser()
        }
        
        // configure button
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = fbLoginContainer.center
        loginButton.delegate = self
        view.addSubview(loginButton)
        
    }
    
    func configureTappableBackground() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tappableBackgroundView.addGestureRecognizer(tapGestureRecognizer)
        tappableBackgroundView.isHidden = true
        view.sendSubview(toBack: tappableBackgroundView)
    }
    
    @objc func backgroundTapped() {
        view.endEditing(true)
        tappableBackgroundView.isHidden = true
    }
    
    func validateUser(){ // TODO
        if let name = nameTextField.text, let _ = passwordTextField.text {
            // validate user and password against database
            // if invalid, set (on screen, not popup, flash fields), return
            user = name
        } else if let id = FBSDKAccessToken.current().userID {
                // validate user against database
                // if facebook is not registered
                    //register
                user = id
        } else {
            return
        }
        
        performSegue(withIdentifier: "ShowHome", sender: nil)
    }
    
}


// MARK: - UITextField Delegate Methods
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tappableBackgroundView.isHidden = false
    }
}

// MARK: - LoginButtonDelegate Methods
extension LoginViewController: LoginButtonDelegate {
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        validateUser()
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        // ensure user is completely logged out of the system
    }
}


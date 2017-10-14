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
    
    // MARK: - IBActions
    @IBAction func LoginButtonPressed(_ sender: UIButton) {
        validateUser()
    }
    
    // MARK: - Methods
    func configureFacebookLogin() {
        // check for existing log in
        if (FBSDKAccessToken.current() == nil) {
            // continue to next screen
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
        // validate user name
        // validate password
        // if invalid, set (on screen, not popup, flash fields)
        // if valid, continue to next screen
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
        // continue to next screen
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
    }
}

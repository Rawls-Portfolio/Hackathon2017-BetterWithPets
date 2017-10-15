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

protocol LoginViewDelegate: class {
    func showHome(user: String, sender: LoginViewController)
}

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    var user: String?
    var delegate: LoginViewDelegate?
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var tappableBackgroundView: UIView!
    @IBOutlet weak var fbLoginContainer: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    // MARK: - View Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        passwordTextField.delegate = self
        configureTappableBackground()
        configureFacebookLogin()
        
        view.backgroundColor = UIColor(hex: "231F20")// dark gray
        passwordTextField.backgroundColor = UIColor(hex: "4D4D4D") // med gray
        passwordTextField.textColor = UIColor(hex: "F7F7F7") // white
        nameTextField.backgroundColor = UIColor(hex: "4D4D4D") // med gray
        nameTextField.textColor = UIColor(hex: "F7F7F7") // white
        loginButton.tintColor = UIColor(hex: "FFD300") // yellow
        nameLabel.textColor = UIColor(hex: "F7F7F7") // white
        passwordLabel.textColor = UIColor(hex: "F7F7F7") // white
        
        view.bringSubview(toFront: profileImage)
        profileImage.isHidden = false
    }

    // MARK: - IBActions
    @IBAction func LoginButtonPressed(_ sender: UIButton) {
        print(#function)
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
    
    func validateUser(){
        print(#function)
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
        delegate?.showHome(user: user ?? "", sender: self )
        
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

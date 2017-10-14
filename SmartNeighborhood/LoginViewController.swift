//
//  LoginViewController.swift
//  SmartNeighborhood
//
//  Created by Amanda Rawls on 10/13/17.
//  Copyright © 2017 Amanda Rawls. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var tappableBackgroundView: UIView!
    
    // MARK: - View Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        passwordTextField.delegate = self
        configureTappableBackground()
        
    }
    
    
    // MARK: - IBActions
    @IBAction func LoginButtonPressed(_ sender: UIButton) {
        validateUser()
    }
    
    // MARK: - Methods
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

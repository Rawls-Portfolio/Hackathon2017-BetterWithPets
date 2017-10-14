//
//  HomeViewController.swift
//  SmartNeighborhood
//
//  Created by Amanda Rawls on 10/14/17.
//  Copyright © 2017 Amanda Rawls. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    // MARK:- Properties
    var model: UserModel?
    
    // MARK:- View Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        print(#function)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
   
}

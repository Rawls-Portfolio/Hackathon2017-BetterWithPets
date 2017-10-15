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
    
    // MARK: - IBOutlets
    @IBOutlet weak var mapContainer: UIView!
    
    // MARK:- View Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load map view controller into map container
        let storyboard = UIStoryboard(name: "GoogleMap", bundle: Bundle.main)
        guard let mapVC = storyboard.instantiateInitialViewController() as? MapsViewController else {
            return
        }
        mapVC.delegate = self
        addToStack(controller: mapVC, to: mapContainer)
    }
    
    func addToStack(controller: UIViewController, to subview: UIView) {
        controller.willMove(toParentViewController: self)
        addChildViewController(controller)
        subview.addSubview(controller.view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        applyConstraints(controller, to: subview)
        controller.didMove(toParentViewController: self)
    }
    
    // MARK: - Child View Controller Constraints Methods
    fileprivate func applyConstraints(_ controller: UIViewController, to subview: UIView) {
        controller.view.leadingAnchor.constraint(equalTo: subview.leadingAnchor).isActive = true
        controller.view.trailingAnchor.constraint(equalTo: subview.trailingAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: subview.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: subview.bottomAnchor).isActive = true
    }
    
    // MARK: - IBAction
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        print(#function)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
   
}

// MARK:- Map View Delegate Methods
extension HomeViewController: MapViewDelegate {
    func save(_ markerModel: MarkerModel) {
        model?.add(markerModel)
    }
    
    
}

//
//  HomeViewController.swift
//  SmartNeighborhood
//
//  Created by Amanda Rawls on 10/14/17.
//  Copyright © 2017 Amanda Rawls. All rights reserved.
//

import UIKit

protocol HomeViewDelegate: class {
    func logout()
}
class HomeViewController: UIViewController {

    // MARK:- Properties
    var model: UserModel?
    weak var delegate: HomeViewDelegate?
    
    // MARK: - IBOutlets
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var activitiesLabel: UILabel!
    @IBOutlet weak var eventsLabel: UILabel!
    @IBOutlet weak var alertsLabel: UILabel!
    
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
        
        view.backgroundColor = UIColor(hex: "231F20")// dark gray
        alertsLabel.textColor = UIColor(hex: "F7F7F7") // white
        alertsLabel.text = "Alerts"
        eventsLabel.textColor = UIColor(hex: "F7F7F7") // white
        activitiesLabel.textColor = UIColor(hex: "F7F7F7") // white
        logoutButton.tintColor = UIColor(hex: "FFD300") // yellow
        navigationController?.navigationBar.barTintColor = UIColor(hex: "231F20")// dark gray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor(hex: "F7F7F7")] // white
       
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
    func applyConstraints(_ controller: UIViewController, to subview: UIView) {
        controller.view.leadingAnchor.constraint(equalTo: subview.leadingAnchor).isActive = true
        controller.view.trailingAnchor.constraint(equalTo: subview.trailingAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: subview.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: subview.bottomAnchor).isActive = true
    }
    // MARK: - IBAction
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        print(#function)
        delegate?.logout()
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
   
}

// MARK:- Map View Delegate Methods
extension HomeViewController: MapViewDelegate {
    func save(_ markerModel: MarkerModel) {
        model?.add(markerModel)
    }
    
    
}

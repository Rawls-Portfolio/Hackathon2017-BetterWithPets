//
//  LandingViewController.swift
//  SmartNeighborhood
//
//  Created by Amanda Rawls on 10/15/17.
//  Copyright © 2017 Amanda Rawls. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    var user: String?
    var isLoggedIn = false
    var goToMap = false
    
    // MARK:- IBOutlets
    @IBOutlet weak var carouselContainer: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var mapLink: UIButton!
    @IBOutlet weak var topBanner: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var storiesButton: UIButton!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var futureButton: UIButton!
    
    // MARK:- View Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCarousel()
        updateCaption(on: 0)
        view.backgroundColor = UIColor(hex: "231F20")// dark gray
        topBanner.backgroundColor = UIColor(hex: "4D4D4D") // med gray
        caption.textColor = UIColor(hex: "F7F7F7") // white
        
        loginButton.tintColor = UIColor(hex: "FFD300") // yellow
        storiesButton.tintColor = UIColor(hex: "FFD300") // yellow
        connectButton.tintColor = UIColor(hex: "FFD300") // yellow
        futureButton.tintColor = UIColor(hex: "FFD300") // yellow
        mapLink.tintColor = UIColor(hex: "FFD300") // yellow
        
    }
    @IBAction func loginTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowLogin", sender: nil)
    }
    
    @IBAction func goToMapAction(_ sender: UIButton) {
        if isLoggedIn {
            performSegue(withIdentifier: "ShowMapView", sender: nil)
        } else {
            goToMap = true
            performSegue(withIdentifier: "ShowLogin", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? ""){
        case "ShowLogin":
            guard let loginVC = segue.destination as? LoginViewController else {
                fatalError("Unexpected Destination: \(segue.destination)")
            }
            
            loginVC.delegate = self
        
        case "ShowMapView":
            guard let navControl = segue.destination as? UINavigationController, let homeVC = navControl.topViewController as? HomeViewController else {
                fatalError("Unexpected Destination: \(segue.destination)")
            }
            homeVC.delegate = self
            homeVC.model = UserModel(user: user ?? "" )
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
    }
    
    func initializeCarousel() {
        let storyboard = UIStoryboard(name: "Carousel", bundle: Bundle.main)
        guard let carouselVC = storyboard.instantiateInitialViewController() as? CarouselViewController else {
            return
        }
        
        carouselVC.captionDelegate = self
        addToStack(controller: carouselVC, to: carouselContainer)
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
}

// MARK:- Login View Delegate Methods
extension LandingViewController: LoginViewDelegate {
    func showHome(user: String, sender: LoginViewController) {
        if user.isEmpty {
            isLoggedIn = false
            profileImage.image = #imageLiteral(resourceName: "Login_Default")
            loginButton.isHidden = isLoggedIn
        } else {
            self.user = user
            isLoggedIn = true
            profileImage.image = #imageLiteral(resourceName: "Login_Brett")
            loginButton.isHidden = isLoggedIn
        }
        sender.dismiss(animated: true, completion: nil)
        
        if goToMap {
            goToMap = false
            goToMapAction(UIButton())
        }
    }
}

// MARK:- Home View Delegate Methods
extension LandingViewController: HomeViewDelegate {
    func logout() {
        isLoggedIn = false
        profileImage.image = #imageLiteral(resourceName: "Login_Default")
        loginButton.isHidden = isLoggedIn
    }
}

// MARK: - Carousel Delegate Methods
extension LandingViewController: CarouselDelegate {
    func updateCaption(on image: Int) {
        switch(image){
        case 0: caption.text = "St. Louis Police K9 Unit uses Unleashed Events\nThe police K9 training unit hosts events around St. Louis and used CU to engage neighborhood residents. Children and adults alike enjoy meeting the patrol dogs and learning about their service."
        case 1: caption.text = "Purina Engages St. Louis Pet Lovers\nThe Outreach Team from Purina uses Community Unleashed to reach local residents with charity events and corporate fundraisers. CU users RSVP for the event and can chat directly on the page with Purina team members."
        case 2: caption.text = "Lost & Found with Unleashed Alerts\nJillian’s cat is missing. With the push of a button she sends Mr. Whisker’s photo and profile out to her neighborhood via a Community Unleashed Alert. Three blocks away and 30 minutes later, Allan spots Mr. Whiskers in the alley and notifies Jillian through the App."
        default: caption.text = ""
        }
    }
}



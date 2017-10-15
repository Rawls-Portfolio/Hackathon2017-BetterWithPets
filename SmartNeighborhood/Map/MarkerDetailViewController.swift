//
//  MarkerDetailViewController.swift
//  SmartNeighborhood
//
//  Created by Amanda Rawls on 10/14/17.
//  Copyright © 2017 Amanda Rawls. All rights reserved.
//

import UIKit

protocol MarkerDetailViewDelegate: class {
    func unwindToMap(with: MarkerModel)
}

class MarkerDetailViewController: UIViewController {
    
    // MARK:- Properties
    var model: MarkerModel?
    weak var delegate: MarkerDetailViewDelegate?
    
    
    //host interaction
    // NF func send/read message board
    // NF func recurring board
    // NF func cancel event
    
    //guest interaction
    // NF func send/read message board
    // NF func report event
    // RSVP
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // if model exists, set title to Edit Marker
        if model == nil {
            self.navigationController?.title = "Edit Marker"
        }
        // TODO: load data
        // if model exists, update marker
        // if model doesn't exist, create new marker
    }
    // MARK:- IBActions
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: nil)
       // return to map
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        // TODO: build model
        let modelData = model!
        delegate?.unwindToMap(with: modelData)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}



//
//  MarkerDetailViewController.swift
//  SmartNeighborhood
//
//  Created by Amanda Rawls on 10/14/17.
//  Copyright © 2017 Amanda Rawls. All rights reserved.
//

import UIKit
import GoogleMaps

protocol MarkerDetailViewDelegate: class {
    func unwindToMap(with: MarkerModel)
    func removeCurrent()
}

class MarkerDetailViewController: UIViewController {
    
    // MARK:- Properties
    var model: MarkerModel?
    var coordinates: CLLocationCoordinate2D?
    weak var delegate: MarkerDetailViewDelegate?
    
    // MARK:- IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var eventTypeControl: UISegmentedControl!
    @IBOutlet weak var isPrivateProperty: UISwitch!
    @IBOutlet weak var eventTextView: UITextView!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var tappableBackground: UIView!
    
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
        
        configureTappableBackground()

        // configure delegates
        titleTextField.delegate = self
        eventTextView.delegate = self
        
        // if model exists, set title to Edit Marker
        if let existing = model {
            self.navigationController?.title = "Edit Marker"
            eventTypeControl.selectedSegmentIndex = existing.eventType.hashValue
            endDatePicker.setDate(existing.endingTime, animated: true)
            startDatePicker.setDate(existing.startTime, animated: true)
            isPrivateProperty.isOn = existing.isPrivateProperty
            titleTextField.text = existing.title
            eventTextView.text = existing.eventDesc
            coordinates = existing.coordinate
        } else {
            eventTextView.text = ""
            startDatePicker.date = Date()
            endDatePicker.date = Date()
            isPrivateProperty.isOn = false
        }
    }
    
    func configureTappableBackground() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tappableBackground.addGestureRecognizer(tapGestureRecognizer)
        tappableBackground.isHidden = true
        view.sendSubview(toBack: tappableBackground)
    }
    
    @objc func backgroundTapped() {
        view.endEditing(true)
        tappableBackground.isHidden = true
    }
    
    func buildModel() -> MarkerModel{
        var coords: CLLocationCoordinate2D
        if coordinates != nil {
            coords = coordinates!
        } else {
            coords = model?.coordinate ?? CLLocationCoordinate2D(latitude: 38.62, longitude: -90.19)
        }
            
        return MarkerModel(title: titleTextField.text, isPrivateProperty: isPrivateProperty.isOn, eventType: EventType.controlConversion(eventTypeControl.selectedSegmentIndex), eventDesc: eventTextView.text, eventIcon: nil, coordinates: coords, startTime: startDatePicker.date, endingTime: endDatePicker.date, hostName: "", hostImage: nil)
    }
    
    // MARK:- IBActions
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: nil)
       // return to map
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        titleTextField.resignFirstResponder()
        eventTextView.resignFirstResponder()
        let modelData = buildModel()
        delegate?.unwindToMap(with: modelData)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func trashButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.removeCurrent()
    }
}

// MARK: - Text Field and Text View Delegate Functions
extension MarkerDetailViewController: UITextFieldDelegate, UITextViewDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        eventTextView.resignFirstResponder()
        tappableBackground.isHidden = true
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tappableBackground.isHidden = false
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        tappableBackground.isHidden = false
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            titleTextField.resignFirstResponder()
            textView.resignFirstResponder()
            tappableBackground.isHidden = true
            return false
        }
        return true
    }

}



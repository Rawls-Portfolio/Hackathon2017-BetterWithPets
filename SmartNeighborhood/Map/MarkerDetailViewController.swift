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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var eventTypeControl: UISegmentedControl!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var isPrivateProperty: UISwitch!
    @IBOutlet weak var eventDescLabel: UILabel!
    @IBOutlet weak var eventTextView: UITextView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var tappableBackground: UIView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
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
        
        eventTypeControl.layer.cornerRadius = 4
        eventTypeControl.clipsToBounds = true
        
        view.backgroundColor = UIColor(hex: "231F20")// dark gray
        titleLabel.textColor = UIColor(hex: "F7F7F7") // white
        titleTextField.backgroundColor = UIColor(hex: "4D4D4D") // med gray
        titleTextField.textColor = UIColor(hex: "F7F7F7") // white
        eventTypeLabel.textColor = UIColor(hex: "F7F7F7") // white
        eventDescLabel.textColor = UIColor(hex: "F7F7F7") // white
        eventTextView.textColor = UIColor(hex: "F7F7F7") // white
        eventTextView.backgroundColor = UIColor(hex: "4D4D4D") // med gray
        startLabel.textColor = UIColor(hex: "F7F7F7") // white
        endLabel.textColor = UIColor(hex: "F7F7F7") // white
        isPrivateProperty.tintColor = UIColor(hex: "FFD300") // yellow
        isPrivateProperty.onTintColor = UIColor(hex: "FFD300") // yellow
        isPrivateProperty.thumbTintColor = UIColor(hex: "231F20")// dark gray
        startDatePicker.backgroundColor = UIColor(hex: "F7F7F7") // white
        endDatePicker.backgroundColor = UIColor(hex: "F7F7F7") // white
        cancelButton.tintColor = UIColor(hex: "FFD300") // yellow
        saveButton.tintColor = UIColor(hex: "FFD300") // yellow
        trashButton.tintColor = UIColor(hex: "FFD300") // yellow
        navigationController?.navigationBar.barTintColor = UIColor(hex: "231F20")// dark gray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor(hex: "F7F7F7")] // white
        
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
        
        eventTypeControl.tintColor = UIColor(hex: "C7CD2D")
    }
    
    func configureTappableBackground() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tappableBackground.addGestureRecognizer(tapGestureRecognizer)
        tappableBackground.isHidden = true
        tappableBackground.backgroundColor = UIColor.clear
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
    
    @IBAction private func madeSelection(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            sender.tintColor = UIColor(hex: "C7CD2D")
        }
        if sender.selectedSegmentIndex == 1{
            sender.tintColor = UIColor(hex: "00A0DC")
        }
        if sender.selectedSegmentIndex == 2 {
            sender.tintColor = UIColor(hex: "9652CC")
        }
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

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

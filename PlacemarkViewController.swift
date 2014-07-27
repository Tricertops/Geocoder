//
//  PlacemarkViewController.swift
//  Geocoder
//
//  Created by Martin Kiss on 26.7.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

import UIKit
import MapKit

class PlacemarkViewController: UITableViewController {
    
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var administrationLabel: UILabel!
    @IBOutlet var localityLabel: UILabel!
    @IBOutlet var thoroughfareLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var waterLabel: UILabel!
    
    var placemark: CLPlacemark? { didSet { updateLabels() }}
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        updateLabels()
    }
    
    func updateLabels() {
        if let placemark = self.placemark {
            countryLabel.text = placemark.country
            administrationLabel.text = placemark.administrativeArea
            if let sub = placemark.subAdministrativeArea {
                administrationLabel.text = "\(administrationLabel.text), \(sub)"
            }
            localityLabel.text = placemark.locality
            if let sub = placemark.subLocality {
                localityLabel.text = "\(localityLabel.text), \(sub)"
            }
            thoroughfareLabel.text = placemark.thoroughfare
            if let sub = placemark.subThoroughfare {
                thoroughfareLabel.text = "\(thoroughfareLabel.text), \(sub)"
            }
            nameLabel.text = placemark.name
            waterLabel.text = placemark.inlandWater
            if let ocean = placemark.ocean {
                if !waterLabel.text? || waterLabel.text.isEmpty {
                    waterLabel.text = ocean
                }
                else {
                    waterLabel.text = "\(waterLabel.text), \(ocean)"
                }
            }
        }
        else {
            countryLabel.text = nil
            administrationLabel.text = nil
            localityLabel.text = nil
            thoroughfareLabel.text = nil
            nameLabel.text = nil
            waterLabel.text = nil
        }
        
        self.tableView.reloadData()
    }
    
}

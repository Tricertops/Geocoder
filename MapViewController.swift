//
//  MapViewController.swift
//  Geocoder
//
//  Created by Martin Kiss on 26.7.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    var placemarkViewController: PlacemarkViewController!
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "embed" {
            if let placemarkVC = segue.destinationViewController as? PlacemarkViewController {
                self.placemarkViewController = placemarkVC
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


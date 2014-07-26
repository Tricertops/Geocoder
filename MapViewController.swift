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
    let pin = MKPointAnnotation()
    var placemarkViewController: PlacemarkViewController!
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    
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
    
    @IBAction func handleTap(gesture: UITapGestureRecognizer) {
        self.mapView.removeAnnotation(self.pin)
        self.pin.title = nil;
        
        let touch = gesture.locationInView(self.mapView)
        let coordinate = self.mapView.convertPoint(touch, toCoordinateFromView:self.mapView)
        self.pin.coordinate = coordinate
        self.mapView.addAnnotation(self.pin)
        
        self.mapView.setCenterCoordinate(coordinate, animated: true)
        
        self.geocoder.cancelGeocode()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let app = UIApplication.sharedApplication()
        app.networkActivityIndicatorVisible = true
        
        self.geocoder.reverseGeocodeLocation(location) {
            placemarks, error in
            app.networkActivityIndicatorVisible = false
            self.placemarkViewController.placemark = nil
            
            if error? {
                UIAlertView(
                    title: "Error",
                    message: error!.localizedDescription,
                    delegate: nil,
                    cancelButtonTitle: "Dismiss")
                    .show()
            }
            else if placemarks.count > 0 {
                if let placemark = placemarks[0] as? CLPlacemark {
                    self.placemark = placemark
                    self.pin.title = placemark.name ? placemark.name! : "Untitled"
                    self.mapView.selectAnnotation(self.pin, animated: true)
                    
                    self.placemarkViewController.placemark = placemark
                }
            }
        }
        
    }
    
}


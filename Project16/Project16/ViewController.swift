//
//  ViewController.swift
//  Project16
//
//  Created by Mohammed Hamdi on 9/4/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        
        let ac = UIAlertController(title: "Map Style", message: "Which map style would you like?", preferredStyle: .alert)
        let standard = UIAlertAction(title: "Standard", style: .default) {
            [weak self] _ in
            self?.mapView.mapType = .standard
        }
        let satellite = UIAlertAction(title: "Satellite", style: .default) {
            [weak self] _ in
            self?.mapView.mapType = .satellite
        }
        ac.addAction(standard)
        ac.addAction(satellite)
        present(ac, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        guard annotation is Capital else { return nil }
        
        // 2
        let identifier = "Capital"
        
        // 3
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        
        
        if annotationView == nil {
            // 4
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = UIColor.blue
            
            // 5
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // 6
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        
        let vc = DetailViewController()
        
        if placeName == "London" {
            vc.link = "https://en.wikipedia.org/wiki/London"
        } else if placeName == "Oslo" {
            vc.link = "https://en.wikipedia.org/wiki/Oslo"
        } else if placeName == "Paris" {
            vc.link = "https://en.wikipedia.org/wiki/Paris"
        } else if placeName == "Rome" {
            vc.link = "https://en.wikipedia.org/wiki/Rome"
        } else if placeName == "Washington DC" {
            vc.link = "https://en.wikipedia.org/wiki/Washington,_D.C."
        }
        
        vc.viewTitle = placeName ?? ""
        navigationController?.pushViewController(vc, animated: true)
        
        /*
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)*/
    }
}


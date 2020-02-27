//
//  ViewController.swift
//  Project22
//
//  Created by Mohammed Hamdi on 9/17/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var distanceReading: UILabel!
    @IBOutlet var beaconName: UILabel!
    @IBOutlet var circle: UIView!
    
    var locationManager: CLLocationManager?
    
    var foundBeacon = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
        
        circle.layer.cornerRadius = 128
        circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
        
        let uuid2 = UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!
        let beaconRegion2 = CLBeaconRegion(proximityUUID: uuid2, major: 456, minor: 123, identifier: "Beacon2")
        locationManager?.startMonitoring(for: beaconRegion2)
        locationManager?.startRangingBeacons(in: beaconRegion2)
        
        let uuid3 = UUID(uuidString: "74278BDA-B644-4520-8F0C-720EAF059935")!
        let beaconRegion3 = CLBeaconRegion(proximityUUID: uuid3, major: 321, minor: 654, identifier: "Beacon3")
        locationManager?.startMonitoring(for: beaconRegion3)
        locationManager?.startRangingBeacons(in: beaconRegion3)
    }
    
    func update(distance: CLProximity, identifier: String) {
        UIView.animate(withDuration: 0.8) {
            switch distance {
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "FAR"
                self.circle.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
                self.circle.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                
            case .immediate:
                self.view.backgroundColor = .red
                self.distanceReading.text = "RIGHT HERE"
                self.circle.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "UNKNOWN"
                self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            }
            
             self.beaconName.text = identifier
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        for beacon in beacons {
            
            if !foundBeacon && beacon.proximity != .unknown {
                let ac = UIAlertController(title: "iBeacon", message: "Found a beacon", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default){ [weak self] _ in
                    self?.foundBeacon = true
                })
                present(ac, animated: true)
            }
            
            if beacon.proximity != .unknown {
                update(distance: beacon.proximity, identifier: region.identifier)
            } else {
                update(distance: .unknown, identifier: "iBeacon")
            }
        }
    }
}


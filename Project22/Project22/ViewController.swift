//
//  ViewController.swift
//  Project22
//
//  Created by Angel Vázquez on 11/1/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

	//	MARK: Outlets
	@IBOutlet var distanceReading: UILabel!
	
	//	MARK: Properties
	var locationManager: CLLocationManager!
	
	
	//	MARK: Life-cycle methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.requestAlwaysAuthorization()
		
		view.backgroundColor = UIColor.gray
	}
	
	//	MARK: Location Manager Delegate Methods
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedAlways {
			if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
				if CLLocationManager.isRangingAvailable() {
					startScanning()
				}
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
		
		print(beacons)
		
		if beacons.count > 0 {
			let beacon = beacons[0]
			update(distance: beacon.proximity)
		} else {
			update(distance: .unknown)
		}
	}
	
	//	MARK: Methods
	func startScanning() {
		let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
		let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "My Beacon")
		
		locationManager.startMonitoring(for: beaconRegion)
		locationManager.startRangingBeacons(in: beaconRegion)
	}
	
	func update(distance: CLProximity) {
		UIView.animate(withDuration: 0.8) { [unowned self] in
			switch distance {
			case .unknown:
				self.view.backgroundColor = .gray
				self.distanceReading.text = "UNKNOWN"
			case .far:
				self.view.backgroundColor = .blue
				self.distanceReading.text = "FAR"
			case .near:
				self.view.backgroundColor = .orange
				self.distanceReading.text = "NEAR"
			case .immediate:
				self.view.backgroundColor = .red
				self.distanceReading.text = "RIGHT HERE"
			}
		}
	}

}


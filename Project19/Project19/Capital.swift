//
//  Capital.swift
//  Project19
//
//  Created by Angel Vázquez on 11/1/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
	var title: String?
	var coordinate: CLLocationCoordinate2D
	var info: String
	
	init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
		self.title = title
		self.coordinate = coordinate
		self.info = info
	}
}

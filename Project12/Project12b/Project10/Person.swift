//
//  Person.swift
//  Project10
//
//  Created by Angel Vázquez on 9/22/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
	var name: String
	var image: String
	
	init(name: String, image: String) {
		self.name = name
		self.image = image
	}
}

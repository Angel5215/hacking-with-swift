//
//  Person.swift
//  Project10
//
//  Created by Angel Vázquez on 9/22/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
	var name: String
	var image: String
	
	init(name: String, image: String) {
		self.name = name
		self.image = image
	}
	
	//	This initializer is used when loading objects of this class.
	required init?(coder aDecoder: NSCoder) {
		name = aDecoder.decodeObject(forKey: "name") as! String
		image = aDecoder.decodeObject(forKey: "image") as! String
	}
	
	// This method is used when saving.
	func encode(with aCoder: NSCoder) {
		aCoder.encode(name, forKey: "name")
		aCoder.encode(image, forKey: "image")
	}
}

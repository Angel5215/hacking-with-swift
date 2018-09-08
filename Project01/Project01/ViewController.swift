//
//  ViewController.swift
//  Project01
//
//  Created by Angel Vázquez on 9/8/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit

//	This class inherits functionality from UITableViewController
class ViewController: UITableViewController {

	var pictures = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//	Data type that lets us work with the filesystem.
		let fm = FileManager.default
		
		//	Path to the images we added in the project.
		let path = Bundle.main.resourcePath!
		
		let items = try! fm.contentsOfDirectory(atPath: path)
		
		for item in items where item.hasPrefix("nssl") {
			pictures.append(item)
		}
		
		print(pictures)
		
	}

	//	This method is called when the system is log on resources.
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}


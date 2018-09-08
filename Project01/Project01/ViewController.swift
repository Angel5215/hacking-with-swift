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
		
		//	Add a title to the navigation controller
		title = "Storm Viewer"
		
		//	iOS 11 large title design guidelines
		navigationController?.navigationBar.prefersLargeTitles = true
		
	}
	
	//	How many rows are in the table view. Table Views can be split in sections, for now, we have only one section.
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pictures.count
	}
	
	//	This method specifies how each row should look like. IndexPath specifies the section and row of a table view cell.
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		//	Identifier that was set up in the Main.storyboard file.
		let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
		
		cell.textLabel?.text = pictures[indexPath.row]
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
			vc.selectedImage = pictures[indexPath.row]
			navigationController?.pushViewController(vc, animated: true)
		}
	}
	

	//	This method is called when the system is log on resources.
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}


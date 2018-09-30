//
//  DetailViewController.swift
//  Project01
//
//  Created by Angel Vázquez on 9/8/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

	@IBOutlet var imageView: UIImageView!
	
	var selectedImage: String?
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		//	Enables the navigation bar to hide with a tap on the screen. Only on this screen.
		navigationController?.hidesBarsOnTap = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		//	Restores the default behavior of the navigation bar.
		navigationController?.hidesBarsOnTap = false
	}
	
	//	iPhone X only. Hides the home indicator after a few seconds. It reappears if the user touches the screen.
	override var prefersHomeIndicatorAutoHidden: Bool {
		return navigationController!.hidesBarsOnTap
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		if let imageToLoad = selectedImage {
			imageView.image = UIImage(named: imageToLoad)
		}
		
		title = selectedImage
		navigationItem.largeTitleDisplayMode = .never
		
		//	Project 3.
		
		//	The target and action parameters go hand in hand. Combined, these parameters tell the UIBarButtonItem what method should be called. The action parameter says the name of the method that should be called; the target parameter tells the button that the method belongs to self (the current view controller)
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
	
	@objc func shareTapped() {
		
		let dataImage = imageView.image!.jpegData(compressionQuality: 0.8)!
		
		//	activityItems is an array of items you want to share. applicationActivities is an array of our own app services.
		let vc = UIActivityViewController(activityItems: [dataImage], applicationActivities: [])
		
		//	Location where the viewController needs to be anchored. Optional because this code only runs on iPads. iPhones display activity view controllers using full screen.
		vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		
		present(vc, animated: true)
	}
	
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

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
	override func prefersHomeIndicatorAutoHidden() -> Bool {
		return navigationController!.hidesBarsOnTap
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		if let imageToLoad = selectedImage {
			imageView.image = UIImage(named: imageToLoad)
		}
		
		title = selectedImage
		navigationItem.largeTitleDisplayMode = .never
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

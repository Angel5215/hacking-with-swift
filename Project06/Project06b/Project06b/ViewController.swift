//
//  ViewController.swift
//  Project06b
//
//  Created by Angel Vázquez on 9/8/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	
	//	Hide the bar that shows what time it is.
	override var prefersStatusBarHidden: Bool {
		return true
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let label1 = UILabel()
		label1.translatesAutoresizingMaskIntoConstraints = false
		label1.backgroundColor = .red
		label1.text = "THESE"
		label1.sizeToFit()
		
		let label2 = UILabel()
		label2.translatesAutoresizingMaskIntoConstraints = false
		label2.backgroundColor = UIColor.cyan
		label2.text = "ARE"
		label2.sizeToFit()
		
		let label3 = UILabel()
		label3.translatesAutoresizingMaskIntoConstraints = false
		label3.backgroundColor = .yellow
		label3.text = "SOME"
		label3.sizeToFit()
		
		let label4 = UILabel()
		label4.translatesAutoresizingMaskIntoConstraints = false
		label4.backgroundColor = UIColor.green
		label4.text = "AWESOME"
		label4.sizeToFit()
		
		let label5 = UILabel()
		label5.translatesAutoresizingMaskIntoConstraints = false
		label5.backgroundColor = .orange
		label5.text = "LABELS"
		label5.sizeToFit()
		
		view.addSubview(label1)
		view.addSubview(label2)
		view.addSubview(label3)
		view.addSubview(label4)
		view.addSubview(label5)
		
		//	Dictionary needed to use VFL
		let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
		
		//	VFL Constraints. For explanation about the syntax of VFL, consult the README.md file.
		for label in viewsDictionary.keys {
			
			//	Add horizontal constraints using VFL.
			view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
		}
		
		//	Add vertical constraints using VFL.
		// 	1. The last label mush be at least 10 points away from the bottom.
		// 	2. Each of the five labels must be 88 points high.
		//	When specifying size of an space, the symbol "-" goes before and after the size, so "-" becomes "-(>=10)-"
		let metrics = ["labelHeight": 88]
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(==labelHeight)]-[label2(==labelHeight)]-[label3(==labelHeight)]-[label4(==labelHeight)]-[label5(==labelHeight)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
		
	}


	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}


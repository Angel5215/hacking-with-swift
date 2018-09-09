//
//  ViewController.swift
//  Project02
//
//  Created by Angel Vázquez on 9/8/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

	@IBOutlet var button1: UIButton!
	@IBOutlet var button2: UIButton!
	@IBOutlet var button3: UIButton!
	
	var countries = [String]()
	var score = 0
	
	var correctAnswer = 0
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		//	Adding elements to the array using the append method.
		countries.append("estonia")
		countries.append("france")
		countries.append("germany")
		
		//	Adding elements using the += operator of arrays. This strategy is more efficient because it uses only one line of code.
		countries += ["ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
		
		
		//	Using CALayer to add a border to the buttons. The values are measured in points. (1 pixel in non-retina screens, 2 pixels in retina screens and 3 pixels in Retina HD screens)
		button1.layer.borderWidth = 1
		button2.layer.borderWidth = 1
		button3.layer.borderWidth = 1
		
		button1.layer.borderColor = UIColor.lightGray.cgColor
		button2.layer.borderColor = UIColor.lightGray.cgColor
		button3.layer.borderColor = UIColor.lightGray.cgColor
		
		
		askQuestion()
    }
	
	func askQuestion(action: UIAlertAction! = nil) {
		
		countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
		
		button1.setImage(UIImage(named: countries[0]), for: .normal)
		button2.setImage(UIImage(named: countries[1]), for: .normal)
		button3.setImage(UIImage(named: countries[2]), for: .normal)
		
		correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)

		title = countries[correctAnswer].uppercased()
	}
	
	@IBAction func buttonTapped(_ sender: UIButton) {
		var title: String
		if sender.tag == correctAnswer {
			title = "Correct"
			score += 1
		} else {
			title = "Wrong"
			score -= 1
		}
		
		let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
		present(ac, animated: true)
	}
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


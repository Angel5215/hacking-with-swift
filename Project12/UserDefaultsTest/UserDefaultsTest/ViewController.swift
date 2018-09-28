//
//  ViewController.swift
//  UserDefaultsTest
//
//  Created by Angel Vázquez on 9/28/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveData(sender: UIButton) {
        
        //  Save data using meaningful keys:
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        
        defaults.set("Paul Hudson", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        //  Saving more complex data types.
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["Name": "Paul", "Country": "UK"]
        defaults.set(dict, forKey: "SavedDict"
            
        )
        
    }
    
    @IBAction func readData(sender: UIButton) {
        let array = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        
        let dict = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()
        
        let arrayMessage = "The array has the following values: \(array)"
        
        let dictionaryMessage = "The dictionary has the following values: \(dict)"
        
        textView.text = arrayMessage + "\n" + dictionaryMessage
    }
}


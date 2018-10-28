//
//  ActionViewController.swift
//  Extension
//
//  Created by Angel Vázquez on 10/27/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

	@IBOutlet var script: UITextView!
	
	var pageTitle = ""
	var pageURL = ""
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		//	Navigation bar
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
		
		//	Observer pattern. Register ActionViewController to NotificationCenter
		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		
		
		
    
        // Get the item[s] we're handling from the extension context.
		if let inputItem = extensionContext!.inputItems.first as? NSExtensionItem {
			if let itemProvider = inputItem.attachments?.first {
				itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [unowned self] (dict, error) in
					let itemDictionary = dict as! NSDictionary
					let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary
					
					print(javaScriptValues)
					
					self.pageTitle = javaScriptValues["title"] as! String
					self.pageURL = javaScriptValues["URL"] as! String
					
					//	In this case, [unowned self] is unneded because the closure will capture the values it needs, which includes self, but we're already inside a closure that has declared self to be unowned, so this closure will use that.
					DispatchQueue.main.async {
						self.title = self.pageTitle
					}
				}
			}
		}
		
    }

    @IBAction func done() {
		let item = NSExtensionItem()
		let argument: NSDictionary = ["customJavaScript": script.text]
		
		let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
		let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
		item.attachments = [customJavaScript]
		
		extensionContext!.completeRequest(returningItems: [item])
    }
	
	@objc func adjustForKeyboard(notification: Notification) {
		let userInfo = notification.userInfo!
		
		let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
		
		let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
		
		if notification.name == UIResponder.keyboardWillHideNotification {
			script.contentInset = UIEdgeInsets.zero
		} else {
			script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
		}
		
		script.scrollIndicatorInsets = script.contentInset
		
		let selectedRange = script.selectedRange
		
		script.scrollRangeToVisible(selectedRange)
	}

}

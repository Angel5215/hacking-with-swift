//
//  ViewController.swift
//  Project21
//
//  Created by Angel Vázquez on 11/1/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
	}
	
	//	MARK: Methods
	
	@objc func registerLocal() {
		let center = UNUserNotificationCenter.current()
		
		center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
			if granted {
				print("Yay!")
			} else {
				print("D'oh")
			}
		}
	}
	
	//	The data neded to schedule a notification: content (what to show), a trigger (when to show it), and a request (the combination of content and trigger)
	@objc func scheduleLocal() {
		
		registerCategories()
		
		let center = UNUserNotificationCenter.current()
		
		let content = UNMutableNotificationContent()
		content.title = "Late wake up call"
		content.body = "The early bird catches the worm, but the second mouse gets the cheese."
		content.categoryIdentifier = "alarm"
		content.userInfo = ["customData": "fizzbuzz"]
		content.sound = UNNotificationSound.default
		
		var dateComponents = DateComponents()
		dateComponents.hour = 10
		dateComponents.minute = 30
		// let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
		
		let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
		
		center.add(request)
	}

	func registerCategories() {
		let center = UNUserNotificationCenter.current()
		center.delegate = self
		
		let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
		let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
		
		center.setNotificationCategories([category])
	}
	
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		//	Pull out the buried userInfo dictionary
		let userInfo = response.notification.request.content.userInfo
		
		if let customData = userInfo["customData"] as? String {
			print("Custom data received: \(customData)")
		}
		
		switch response.actionIdentifier {
		case UNNotificationDefaultActionIdentifier:
			print("Default identifier")
		case "show":
			print("Show more information")
		default:
			break
		}
	}

}


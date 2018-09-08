//
//  ViewController.swift
//  Project04
//
//  Created by Angel Vázquez on 9/8/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
	
	var webView: WKWebView!
	
	var progressView: UIProgressView!
	
	var websites = ["apple.com", "hackingwithswift.com"]
	
	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let url = URL(string: "https://" + websites[0])!
		webView.load(URLRequest(url: url))
		webView.allowsBackForwardNavigationGestures = true
		
		//	Adding buttons
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
		
		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
		
		progressView = UIProgressView(progressViewStyle: .default)
		progressView.sizeToFit()
		let progressButton = UIBarButtonItem(customView: progressView)
		
		toolbarItems = [progressButton, spacer, refresh]
		navigationController?.isToolbarHidden = false
		
		//	Who is the observer is the first parameter. What property are we observing. Which vallue we want. Context value.
		webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
	}
	
	//	This method needs to be implemented whenever you have registered as an observer using KVO (addObserver method)
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "estimatedProgress" {
			progressView.progress = Float(webView.estimatedProgress)
		}
	}
	
	@objc func openTapped() {
		let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
		
		for website in websites {
			ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
		}
		
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		
		ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		
		present(ac, animated: true)
	}
	
	func openPage(action: UIAlertAction) {
		let url = URL(string: "https://" + action.title!)!
		webView.load(URLRequest(url: url))
	}
	
	//	WKNavigationDelegate protocol methods.
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		title = webView.title
	}
	
	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		let url = navigationAction.request.url
		
		//	Host means website domain (apple.com). Not all URLs have hosts.
		if let host = url!.host {
			for website in websites {
				if host.range(of: website) != nil {
					decisionHandler(.allow)
					return
				}
			}
		}
		
		decisionHandler(.cancel)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}


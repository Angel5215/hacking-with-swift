//
//  DetailViewController.swift
//  Project07
//
//  Created by Angel Vázquez on 9/21/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
	
	var webView: WKWebView!
	var detailItem: [String: String]!
	
	override func loadView() {
		webView = WKWebView()
		view = webView
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		guard detailItem != nil else { return }
		
		if let body = detailItem["body"] {
			let html = """
			<html><head>
			<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
			<style> body { font-size: 150%; } </style>
			</head><body>\(body)</body></html>
			"""
			webView.loadHTMLString(html, baseURL: nil)
		}
		
    }
}

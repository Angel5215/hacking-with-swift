//
//  ViewController.swift
//  Project05
//
//  Created by Angel Vázquez on 9/8/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {
	
	var allWords = [String]()
	var usedWords = [String]()
	var currentWord = -1

	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
		
		if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
			if let startWords = try? String(contentsOfFile: startWordsPath) {
				allWords = startWords.components(separatedBy: "\n")
			} else {
				loadDefaultWords()
			}
		} else {
			loadDefaultWords()
		}
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
		
		startGame()
	}
	
	//	Enhancement 4.
	func loadDefaultWords() {
		allWords = ["berserker", "analyze", "cottage", "honorary", "effective", "beach", "identity", "apparition", "ageless", "program", "dismember", "cows", "shark", "actuality", "creeper", "germ", "virgin", "folding", "skyline", "dead", "trust", "circus", "external", "show", "gladness", "pigeon", "risky", "queen", "heating", "honorary", "evidence", "salt", "god", "heavy", "hearted", "immunity", "perplexing", "evolution", "mightiest", "popular", "bottomless", "calculation", "hell", "average", "observer", "cathedral", "homicidal", "honor", "sideways", "flood", "contaminant"]
	}
	
	@objc func startGame() {
		
		//	Enhancement 5.
		if currentWord == allWords.count - 1 || currentWord == -1 {
			allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
			currentWord = 0
		} else {
			currentWord += 1
		}
		
		print("The current index is \(currentWord)")
		
		title = allWords[currentWord]
		
		usedWords.removeAll(keepingCapacity: true)
		tableView.reloadData()
	}
	
	@objc func promptForAnswer() {
		let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
		ac.addTextField()
		
		
		let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] (action: UIAlertAction) in
			let answer = ac.textFields![0]
			self.submit(answer: answer.text!)
		}
		
		ac.addAction(submitAction)
		present(ac, animated: true)
	}
	
	func submit(answer: String) {
		let lowerAnswer = answer.lowercased()
		
		//	Enhancement 3. Word is the same as the title.
		if lowerAnswer == title {
			showErrorMessage(title: "Word is equal", message: "You can't just repeat the same word!")
			return
		}
		
		if isPossible(word: lowerAnswer) {
			if isOriginal(word: lowerAnswer) {
				if isReal(word: lowerAnswer) {
					usedWords.insert(answer, at: 0)
					let indexPath = IndexPath(row: 0, section: 0)
					
					//	This method shows insertion into the table view with an animation for visual and permormance. Adding one cell is easier than realoding all data.
					tableView.insertRows(at: [indexPath], with: .automatic)
					return
					
				} else {
					//	Enhancement 2. Refactor
					showErrorMessage(title: "Word not recognised", message: "You can't just make them up, you know!")
				}
			} else {
				showErrorMessage(title: "Word used already", message: "Be more original!")
			}
		} else {
			showErrorMessage(title: "Word not possible", message: "You can't spell that word from \(title!.lowercased())")
		}
	}
	
	
	func showErrorMessage(title: String, message: String) {
		let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default))
		present(ac, animated: true)
	}
	
	func isPossible(word: String) -> Bool {
		var tempWord = title!.lowercased()
		
		for letter in word {
			if let pos = tempWord.range(of: String(letter)) {
				tempWord.remove(at: pos.lowerBound)
			} else {
				return false
			}
		}
		
		return true
	}
	
	func isOriginal(word: String) -> Bool {
		return !usedWords.contains(word)
	}
	
	func isReal(word: String) -> Bool {
		
		//	Enhancement 1. Count check
		if word.count < 3 {
			return false
		}
		
		//	Class designed to spot spelling errors.
		let checker = UITextChecker()
		let range = NSMakeRange(0, word.utf16.count)
		let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
		
		return misspelledRange.location == NSNotFound
	}
	
	//	Table View Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return usedWords.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
		cell.textLabel?.text = usedWords[indexPath.row]
		
		return cell
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}







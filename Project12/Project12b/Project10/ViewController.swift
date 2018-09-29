//
//  ViewController.swift
//  Project10
//
//  Created by Angel Vázquez on 9/22/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	var people = [Person]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
		
		//	Reading information when app launches using Codable:
		let defaults = UserDefaults.standard
		if let savedPeople = defaults.object(forKey: "people") as? Data {
			let jsonDecoder = JSONDecoder()
			do {
				people = try jsonDecoder.decode([Person].self, from: savedPeople)
			} catch {
				print("Failed to load people")
			}
		}
	}
	
	@objc func addNewPerson() {
		let picker = UIImagePickerController()
		picker.allowsEditing = true
		picker.delegate = self
		present(picker, animated: true)
	}

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return people.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell
		
		let person = people[indexPath.item]
		cell.name.text = person.name
		
		let path = getDocumentsDirectory().appendingPathComponent(person.image)
		cell.imageView.image = UIImage(contentsOfFile: path.path)
		
		//	Rounded corners of ImageView using CALayer
		cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
		cell.imageView.layer.borderWidth = 2
		cell.imageView.layer.cornerRadius = 3
		cell.layer.cornerRadius = 7
		
		return cell
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		guard let image = info[.editedImage] as? UIImage else { return }
		
		let imageName = UUID().uuidString
		let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
		
		if let jpegData = image.jpegData(compressionQuality: 80) {
			try? jpegData.write(to: imagePath)
		}
		
		let person = Person(name: "Unknown", image: imageName)
		people.append(person)
		collectionView.reloadData()
		
		dismiss(animated: true)
		
		save()
	}
	
	func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let documentsDirectory = paths[0]
		
		return documentsDirectory
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let person = people[indexPath.item]
		
		let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
		ac.addTextField()
		
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		ac.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self, ac] _ in
			let newName = ac.textFields![0]
			person.name = newName.text!
			
			self.collectionView.reloadData()
			self.save()
		})
		
		present(ac, animated: true)
	}
	
	//	UserDefaults using Codable
	func save() {
		let jsonEncoder = JSONEncoder()
		if let savedData = try? jsonEncoder.encode(people) {
			let defaults = UserDefaults.standard
			defaults.set(savedData, forKey: "people")
		} else {
			print("Failed to save people")
		}
	}
	
}


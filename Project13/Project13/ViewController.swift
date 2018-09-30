//
//  ViewController.swift
//  Project13
//
//  Created by Angel Vázquez on 9/29/18.
//  Copyright © 2018 Angel Vázquez. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet var imageView: UIImageView!
	@IBOutlet var intensity: UISlider!
	
	var currentImage: UIImage!
	
	//	Component that handles rendering.
	var context: CIContext!
	
	//	Stores whatever filter you activate. It is given various input settings before asking it to output a result.
	var currentFilter: CIFilter!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//	Yet Another Core Image Filters Program
		title = "YACIFP"
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
		
		//	Context and sepia filter.
		context = CIContext()
		currentFilter = CIFilter(name: "CISepiaTone")
		
	}
	
	@objc func importPicture() {
		let picker = UIImagePickerController()
		picker.allowsEditing = true
		picker.delegate = self
		present(picker, animated: true)
	}
	
	

	@IBAction func changeFilter(_ sender: Any) {
		let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet) 
		ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		
		present(ac, animated: true)
	}
	
	func setFilter(action: UIAlertAction) {
		guard currentImage != nil else { return }
		
		currentFilter = CIFilter(name: action.title!)
		
		let beginImage = CIImage(image: currentImage)
		currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
		
		applyProcessing()
	}
	
	@IBAction func save(_ sender: Any) {
		
		guard let imageToSave = imageView.image else { return }
		
		UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
	}
	
	@objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
		
		if let error = error {
			let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK", style: .default))
			present(ac, animated: true)
		} else {
			let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "Ok", style: .default))
			present(ac, animated: true)
		}
		
	}
	
	@IBAction func intensityChanged(_ sender: Any) {
		guard currentImage != nil else { return }
		applyProcessing()
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[.editedImage] as? UIImage else { return }
		
		dismiss(animated: true)
		
		currentImage = image
		
		let beginImage = CIImage(image: currentImage)
		currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
		applyProcessing()
	}
	
	func applyProcessing() {
		
		let inputKeys = currentFilter.inputKeys
		
		if inputKeys.contains(kCIInputIntensityKey) {
			currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
		}
		
		if inputKeys.contains(kCIInputRadiusKey) {
			currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)
		}
		
		if inputKeys.contains(kCIInputScaleKey) {
			currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
		}
		
		if inputKeys.contains(kCIInputCenterKey) {
			currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
		}
	
		
		
		//	Creates a CGImage from the output image of the current filter. We need to specify which part of the image we want to render, using the extent property means all of it.
		if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
			let processedImage = UIImage(cgImage: cgimg)
			imageView.image = processedImage
		}
	}
}


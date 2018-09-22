
# Project 08. 7 Swifty Words.

## Concepts

* Property observers
* Search through arrays
* Modulo
* Array enumeration
* Ranges
* String methods:
	* `components(separatedBy:)`
	* `replacingOccurrences(of:with:)`
	* `joined(separator:)`


## Notes

`view.subviews` is an array containing all the `UIView`s placed in the ViewController.

`addTarget` is the equivalent in code to CTRL-dragging from the storyboard to create an `@IBAction`.

The `enumerated` method of arrays let us loop through the array and also having access to the index:

```swift
for line in lines {
	// Code. Don't have an easy access to the index position of line.
}

for (index, line) in lines.enumerated() {
	// Code. Has an easy access to the index.
}
```

You can use the `where` keyword to simplify a `for` loop:

```swift
//	Not using where:
for subView in view.subviews {
	if subView.tag == 1001 {
		//	Code.
	}
}

//	Using where:
for subView in view.subViews where subView.tag == 1001 {
	//	Code.
}
```


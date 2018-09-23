
# Project 10. Names to Faces.

## Concepts

* Collection Views.
* `UICollectionViewController`
* `UIImagePickerController`
* `Data`
* `UUID`
* `CALayer`
* `UIAlertController`
* More on closures.
* `UUID` (Universally Unique Identifier)
* `Filemanager.default.urls(for:in:)`

## Notes

Collections Views are extremely similar to Table Views, with the exception that they display as **grids** rather than as simple rows.

All apps that are installed have a directory called **Documents** where you can save private information for the app, and it's also automatically synchronized with iCloud.

`FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)` asks for the documents directory, and its second parameter adds that we want the path to be relative to the user's home directory. It returns an array.
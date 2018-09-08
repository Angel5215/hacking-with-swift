
# Project 1. Storm Viewer.

## Concepts

- `UIActivityViewController`
- `#selector` and `@objc`
- `Info.plist` file.


## Notes

The `#selector(shareTapped)` syntax tells Swift that a method called "shareTapped" will exist and should be triggered when the button is tapped.

The annotation `@objc` is used because the method will get called by the underlying Objective-C operating system. Thus, the method need to be marked as being available to Objective-C code. When you call a method using `#selector`, that method needs to use the `@objc` annotation.



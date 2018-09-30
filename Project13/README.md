
# Project 13. Instafilter

## Concepts

- Core Image. High-speed image manipulation toolkit.
- `UIImagePickerControllerDelegate`

## Notes

Core Image is an Apple framework that is designed to apply filters to images and manipulate them in various ways. One downside to Core Image is that it's not very *guessable*, you need to know what you're doing otherwise you'll waste a lot of time. It's also not able to realyl on large parts of Swift's type safety, so you need to be careful when using it.

### Context

A Core Image **context** is the component that handles rendering. Creating a context is computationally expensive, so you might prefer to create it only once.

## More

For more information on filters: [Core Image Filter Reference](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html)

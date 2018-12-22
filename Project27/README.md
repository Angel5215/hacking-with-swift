
# Project 27. Core Graphics.

## Concepts

- Core Graphics.
- `UIGraphicsRenderer` class.
- `UIGraphicsImageRendererContext` <-> `CGContext`
- `UIFont`
- `NSMutableParagraphStyle()`.
- `NSAttributedString.Key.font`, `NSAttributedString.Key.paragraphStyle`

## Notes

Core Graphics is a framework responisble for independent 2D drawing (shapes, paths, shadows, colors, etc). It's device-independent, so you can draw things to the screen or draw them in a PDF without having to change your code.

Core Graphics can work on a background thread - something that UIKit can't do. You can do complicated drawing withoud locking up your user interface.

In Core Graphics, a **context** is a canvas upon which we can draw, but it also stores information about how we want to draw (e.g. line thickness) and information about the device we are drawing to. In other words, it is a combination of *canvas* and *metadata* all in one. This context is exposed to us when we render with `UIGraphicsImageRenderer`.

`UIFont` defines a font name and size. `NSMutableParagraphStyle()` is used to describe paragraph formatting options, such as line height, indents and alignment.


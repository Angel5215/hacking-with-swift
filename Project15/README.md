
# Project 15. Animation

## Concepts

- `CGAffineTransform` struct.
- `UIView.animate()`
- Core Animation.

## Notes

A `CGAffineTransform` is a structure that represents a specific kind of transformation that can be applied to any `UIView` and its subclasses.

Apple provides many helper functions (scaling, rotating, moving) to make animations easier. Each of these functions return a `CGAffineTransform` that can be assigned into a `UIView`s `transform` property. Core Animation calculates all the intermediary steps of this process automatically.

By default, UIKit animations have a "**ease in**, **ease out**" curve which means that movement starts slow, then accelerates, then slows down near the end.

### Rotation

1. When you're trying to rotate a view, you have to provide the value in **radians**.

2. Core Animation will always take the shortest route for a rotation to work. Supposing you have a view with a 0º rotation and you decide to make a 90º rotation, it will happen counter-clockwise. On the other hand, if you apply a 270º rotation to a view with 0º rotation, it will happen clockwise.

3. A consequence of the last rule is that if you try to rotate a view 360º, nothing will happen. The same applies to bigger rotations, like 540º (360º + 180º), Core Animation will only rotate the view 180º.

### Animating properties

Core Animation also allows to animate a `UIView` property like: background color, transparency, etc. You can animate multiple things at once if you want something complicated to happen.







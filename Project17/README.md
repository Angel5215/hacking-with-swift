
# Project 17. Swifty Ninja

## Concepts

- `SKShapeNode`
- `AVAudioPlayer`
- `SKAction` groups
- `UIBezierPath`
- `CGVector`
- Enumerations `enum`, custom enums.

## Notes

The default gravity of the `physicsWorld` in SpriteKit is **-0.98** by default.

A `SKShapeNode` lets you define any kind of shape you can draw, along with line width, stroke color and more, and it will render it to the screen.

A `SKShapeNode` object has a `path` property which describes the shape we want to draw. This `path` expects a `CGPath` that can be easily created using `UIBezierPath`.

The `update(currentTime:)` method of SpriteKit is called every frame before it is drawn. This method allows us to update the game state as we want.

An action group in SpriteKit specifies that all actions inside it should execute simultaneously. On the other hand, an action sequence executes them all one at a time.




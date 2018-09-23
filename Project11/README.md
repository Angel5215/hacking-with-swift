
# Project 11. Pachinko

## Concepts

* SpriteKit: sprites, fonts, physics, particle effects.
* `SKView`
* `SKSpriteNode` <--> `UIImage`
* `SKPhysicsBody`
* `SKAction`
* `SKPhysicsContactDelegate`
* Introduction to **Bitmasks**: `contactTestBitmask`



## Notes

SpriteKit is Apple's fast and easy toolkit designed specifically for 2D games.

The node count refers to how many things are on screen when using the app. You're aiming for 60 frames per second all the time, if possible.

SpriteKit's equivalent of Interface Builder is called the **Scene Editor**. It is located by default in the `GameScene.sks` file.

The **Anchor Point** determines what coordinates SpriteKit uses to position children. It is **X:0.5, Y:0.5 by default**.

Sprite Kit considers Y:0 to be the bottom of the screen whereas UIKit considers it to be the top.

The ViewController in the Game Template is there only to host your SpriteKit Game. The equivalent of screens in SpriteKit are called **scenes**.

The `touchesBegan()` method is called whenever someone starts touching the Device. It's possible that they started touching with multiple fingers at the same time, so the data type that gets passed is a `Set` (similar to an array but each object can appear only once, i.e. duplicates are not allowed).

The `isDynamic` property of a physics body is a boolean value. When it is set to true, the object will be moved by the physics simulator based on gravity and colisions. When it's false, the object will still collide with other things, but it won't ever be moved as a result.

As with UIKit, it's easy to store a variable pointing at specific nodes in your scene for when you want to make something happen, and there are lots of times when that's the right solution. But for general use, Apple recommends assigning names to your nodes, then checking the name to see what node it is.

The `SKPhysicsContactDelegate` protocol is able to tell us when contact occurs between two bodies.

The `collisionBitMask` roughly means "which nodes should I bump into?", and it is set by default to "everything". On the other hand, `contactTestBitMask` means "which colissions do you want to know about?" and by default it is set to nothing.



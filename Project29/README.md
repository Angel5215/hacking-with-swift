
# Project 29. Exploding Monkeys.

## Concepts

- HSB Color.
- Texture atlases.
- Scene transitions.
- Mixing UIKit with SpriteKit.
- Destructible terrain.
- `stride(from:to:by:)`, `stride(from:through:by:)`
- `CGVector`

## Notes

HSB (Hue, Saturation, Brightness) is a way of creating colors.

- **Hue** is a value from 0 to 1. It represents a position on a color wheel. Hues 0 and 1 both represent red, with all other colors lying in between.
- **Saturation** is a value from 0 to 1. It is used to control how saturated a color is (0 = gray, 1 = pure color).
- **Brightness** is a value from 0 (black) to 1 (maximum brightness). 

The helpful thing about HSB is that if you keep the saturation and brightness contstant, changing the hue value will cycle through all possible colors. It's an easy way to generate matching pastel colors, for example.

### Texture atlases

A texture atlas is a folder with the extension `.atlas`. SpriteKit takes all the images inside the atlas and sewns them into a single image file and a property list file describing it. This means it can draw lots of images without having to load and unload textures - it effectively just crops the big image as needed. SpriteKit automatically creates these atlases for use, even rotating sprites to make them fit if needed. Finally, just like using `Assets.xcassets`, you don't need to change your code to make them work; just load sprites the same way you've always done.

### `usesPreciseCollisionDetection`

SpriteKit uses a number of optimizations to help its physics simulation work at high speed. These optimization don't work well with small, fast-movint objects. To ensure everything works as intended, this project enables the `usesPreciseCollisionDetection` property of the banana's physics body (it's slower but fine for occasional use).


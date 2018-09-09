
# Project 2. Guess the Flag

## Concepts

- Interface Builder
- @2x and @3x images
- Asset Catalogs (`Assets.xcassets`)
- `UIButton`
- Enums
- `CALayer` (Core Animation)
- `UIColor` and `CGColor` (Core Graphics)
- Random numbers (`GameplayKit`)
- Actions (`@IBAction`) and outlets (`@IBOutlet`)
- String interpolation (`let message = "Your score is \(score)"`)
- `UIAlertController`

## Notes

### Pixels and Points

Early iOS devices had non-retina screens. This meant a screen resolution of 320 x 480 pixels. So you could place things exactly where you wanted them.

With iPhone 4, Apple introduced retina screens that had double the number of pixels as previous screens. Apple automatically switched sizes from pixels to **points** (virtual pixels). On non-retina devices, 10 points became 10 pixels, but on retina devices 10 points became 20 pixels. This changes guarantee that everything looked the same size and shape on both devices, with a single layout.

Retina HD screens have a 3x resolution. 

The AppStore uses a technology called **app thinning** so that it delivers only the content each device is capable of showing (it strips out other assets to reduce wasted space). As of iOS 10, no non-retina devices are supported.

### `CALayer`

Views in iOS are backed by what's called a `CALayer`, a Core Animation data type responsible for managing the way the view looks.

### Alerts

The `preferredStyle` parameter of `UIAlertController` initializers offers two styles: `.alert` and `.actionSheet`. The first one is used when you're telling users about a situation change. On the other hand, `.actionSheet` is best used when asking users to choose from a set of options.


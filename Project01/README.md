
# Project 1. Storm Viewer.

## Concepts

- Constants (`let`) and variables (`var`)
- Method overrides (`override` keyword)
- Table View Controller
- Table View Cell
- `FileManager`
- Typecasting (`as?`)
- Arrays (`[String]`)
- Loops (`for` keyword)
- View Controllers
- Storyboards
- Outlets (`@IBOutlet`)
- Auto Layout
- `UIImage`
- `UIKit`


## Notes

An iOS app is a directory containing lots of files: the binary, the media assets, visual layout files, and a variety of other things. These app directories are called **Bundles**.

A **View controller** is a screen of information.

The `viewDidLoad()` method is called when the screen has loaded and is ready for us to customize.

The `let` keyword is used to declare **constants**. The `var` keyword is used to create variables.

If you try to use a constant or variable that has a `nil` value, the app will crash.

UIKit is the iOS user interface framework. It contains a lot of built-in user interface tools that can be used to build apps.

**Storyboards** contain the user interface of an app and let us visualize some or all of it on a single screen.

A **Table View Cell** is responsible for displaying one row of data in a table.

To save CPU time and RAM, iOS only creates as many rows as it needs to work in a Table View. When one row moves off the top of the screen, iOS will take it away and put it into a **reuse queue** ready to be recycled into a new row that comes in from the bottom. 

Note: All recycled cells will contain the previous content if it's not cleaned.

**Auto Layout** lets us define rules for how views should be laid out, and it automatically makes sure those rules are followed. Auto Layout has two rules:

1. The layout rules **must be complete**: for every X position specified, you must also specify a Y position.
2. The layout rules **must not conflict**. 

Auto Layout rules are called **constraints**, they can be created entirely inside **Interface Builder**. 

Every View Controller has a property called `storyboard` that is either the storyboard it was loaded from or `nil`.

Some other methods that are used:

* `viewWillAppear()`: The view is about to be shown
* `viewDidAppear()`: The view has been shown
* `viewWillDisappear()`: The view is about to go away
* `viewDidDisappear()`: The view has gone away




# Project 6. Auto Layout.

This is actually divided into two different Xcode projects called `Project06a` and `Project06b`. The first one aims to fix [Project 2](./../Project02) to demonstrate more advanced Auto Layout techniques while also making the flags in the game stay on the screen correctly (even with landscape orientation). The second one shows Auto Layout in code.

## Concepts in 6a.

- Inequality constraint (>=, <=, ==)
- Aspect ratio
- Equal heights


## Concepts in 6b

- Auto Resize
- NSLayoutConstraints
- Auto Layout Visual Format Language (VFL)

## Notes

By default, iOS generates Auto Layout constraints for you based on a view's size and position. If we're specifying them by hand, we need to disable this feature setting the property `translatesAutoresizingMaskIntoConstraints` to `false`.

We can specify constraints using **Auto Layout Visual Format Language (VFL)**, which is a way of "drawing" the layout you want with a series of keyboard symbols.

### Example

An example of a VFL string: `"H:|[label1]|"`.

This string describes how we want the layout to look. The VFL string gets converted into Auto Layout constraints, then added to the view.

* `H:`means we're defining a **horizontal** constraint.
* `|`means **the edge of the view**
* `[label1]` means put `label1` here.

In other words, this means "horizontally, I want `label1` to to edge to edge in my view". What's `label1`? The label specified by the key `"label1"` in the `viewsDictionary`.








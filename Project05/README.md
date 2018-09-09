
# Project 5. Word Scramble

## Concepts

- Closures (trailing closures)
- Capture list (`[unowned self, ac]`)
- Files
- Strong reference cycle
- Return types
- Boolean values
- `Character` and `range(of:)` method of `String`.
- `UITextChecker`

## Notes

Closures are chunks of code that can be treated as variables. We can send the closure somewhere, where it gets stored away and executed later. To make this work, Swift **takes a copy** of the code and **captures** any data it references, so it can use them later.

What if the closure references the View Controller?

What could happen is a **strong reference cycle**: the view controller owns an object that owns a closure that owns the view controller, and nothing could ever be destroyed. This leads to a **memory leak**.

### Strong reference cycle

An object `A` owns an object `B` and object `B` owns a closure that references object `A`. When closures are created, they capture everything they use, thus object `B` owns object `A`.

### More on closures

Closures can be thought of as a bit like *anonymous functions*. Rather than passing the name of a function to execute, we're just passing a lump of code.

Example of a regular closure using Alerts:

```swift
UIAlertAction(title: "Continue", style: .default, handler: {
	//	CLOSURE CODE
})
```

This code can be rewritten using **trailing closure syntax**. If a method has a closure as its final parameter, you can omit that final parameter entirely and pass it inside braces instead. We can rewrite the last piece of code as:

```swift
UIAlertAction(title: "Continue", style: .default) {
	//	CLOSURE CODE
}
```

### Captured values 

Swift **captures** any constants and variables that are used inside a closure, based on the values of the closure's surrounding context. If you create an Integer, a String, an arrao and anothe class outside of the closure, then use them inside the closure, Swift captures them.

You need to be extra careful with captured valued and reference cycles. You must tell Swift what variables you don't want strong references for. This is done in two ways: `unowned` (similar to implicitly unwrapped optionals) or `weak` (similar to regular optionals).

A weakly owned reference might be `nil`, so you need to unwrap it. An unowned reference is one you're certifying cannot be `nil` and doesn't need to be unwrapped. 

## String compatibility - UTF16

Swift strings natively store international characters as individual characters. Thus, the letter `é` is stored as precisely that. However, UIKit was written in Objective-C and it uses a different character system called UTF-16 (short for 16-bit Unicode Transformation Format) where the accent and the letter are stored separately.

**Simple rule**: When working with UIKit, SpriteKit or any other Apple Framework, use `utf16.count` for character count in Strings. Use `count` instead if it's your own code.


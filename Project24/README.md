
# Project 24. Swift Extensions

## Concepts

- Extensions
- Protocol-Oriented Programming
- `BinaryInteger`

## Notes

`self` means "my current value".

`Self` means "my current data type".

`BinaryInteger` is the protocol applied to `Int`, `Int8`, `UInt64` and so on. This means **all** integer types get acces to the squared method:

```swift
extension BinaryInteger {
    func squared() -> Self {
        return self * self
    }
}
```

### Why use extensions?

Extensions work across all data types, and they don't conflict when you have more than one. 

With extensions you can have ten different pieces of functionality in ten different files - they can all modify a class directly, and you don't need to subclass anything. 

A common naming scheme for naming extension files is: `Type+Modifier.swift`. For example: `String+RandomLetter.swift`.
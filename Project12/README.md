
# Project 12. `UserDefaults`.

## Concepts

- `UserDefaults`
- `Codable` and `NSCoding` protocols
- `NSKeyedArchiver`, `NSKeyedUnarchiver` 
- `JSONEncoder` and `JSONDecoder`
- The nil coalescing operator: `??`
- `NSCoder`, `NSObject` and `NSCoding`
- `required init`

## Notes

The `Codable` protocol is only available to Swift developers. The `NSCoding` protocol is available to both Swift and Objective-C developers. These protocols can be used to convert custom objects into data that can be written to disk. 

`UserDefaults` can be used to store any basic data type (`Bool`, `Float`, `Double`, `Int`, `String`, `URL`, arrays, dictionaries and `Date`, `Data`) **for as long as the app is installed**.

The data stored with `UserDefaults` is automatically read when you launch the app. It is a bad a idea to stre lots of data.

`UserDefaults` was written for use with `NSString` and alike, all of which are 100% interchangeable with their Swift equivalents. In Swift, strings, arrays and dictionaries are all **structs**.

### Reading with `UserDefaults`

Check the return type of common methods:

- `integer(forKey:)`: returns an integer if the key existed, 0 if not.
- `bool(forKey:)`: returns a boolean if the key existed, false otherwise.
- `float(forKey:)`: returns a float if the key existed, 0.0 otherwise.
- `double(forKey:)`: returns a double if the key existed, 0.0 otherwise.
- `object(forKey:)`: returns `Any?`, you need to typecast to the actual data type using `as?` or `as!`.


### How do types become compatible with `UserDefaults`?

You can save any kind of data inside `UserDefaults` as long as you follow some rules:

1. All the data types must be one of the following: boolean, integer, float, double, string, array, dictionary, `Date` or a class that fits rule 2.

2. If your data type is a class, it must conform to the `NSCoding` protocol, which is used for archiving object graphs (objects that refer to objects that refer to objects and so on).

3. If your data type is an array or dictionary, all the keys and values must match rule 1 or rule 2.

Note. When using `NSCoding`, you have to use a class that inherits from `NSObject`. 

### Encoding.

The `NSCoder` class is responsible for both encoding (writing) and decoding (reading) your data so that it can be used with `UserDefaults`.

When using `NSCoding` you have to implement a `required` initializer: `required init(coder aDecoder: NSCoder)`.

#### `required init`

When subclassing a class that has a `required` init, you have to implement that initializer in the subclass.

An alternative use of `required` is to declare that a class can never be subclassed.  
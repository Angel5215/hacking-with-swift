
# Project 12. `UserDefaults`.

## Concepts

- `UserDefaults`
- `Codable` and `NSCoding` protocols
- `NSKeyedArchiver`, `NSKeyedUnarchiver` 
- `JSONEncoder` and `JSONDecoder`
- The nil coalescing operator: `??

## Notes

The `Codable` protocol is only available to Swift developers. The `NSCoding` protocol is available to both Swift and Objective-C developers. These protocols can be used to convert custom objects into data that can be written to disk. 

`UserDefaults` can be used to store any basic data type (`Bool`, `Float`, `Double`, `Int`, `String`, `URL`, arrays, dictionaries and `Date`, `Data`) **for as long as the app is installed**.

The data stored with `UserDefaults` is automatically read when you launch the app. It is a bad a idea to stre lots of data.

`UserDefaults` was written for use with `NSString` and alike, all of which are 100% interchangeable with their Swift equivalents. In Swift, strings, arrays and dictionaries are all **structs**.

### Reading with `UserDefaults`

Check the return type of common methods:

- `integer(forKey:)`: returns an integer if the key existed, 0 if not.
- `bool(forKey:)`: returns a boolean if the key existed, false otherwise.
- `float(forKey:)`: returns a float if the key existed, 0.0 otherwise.
- `double(forKey:)`: returns a double if the key existed, 0.0 otherwise.
- `object(forKey:)`: returns `Any?`, you need to typecast to the actual data type using `as?` or `as!`.




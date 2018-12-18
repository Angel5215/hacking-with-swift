
import UIKit

var myInt = 0

extension Int {
	mutating func plusOne() {
		self += 1
	}
}

myInt.plusOne()
// 5.plusOne()

myInt = 10
myInt.plusOne()
myInt

let otherInt = 10
// otherInt.plusOne()

//	Protocol-Oriented Programing
extension BinaryInteger {
	func squared() -> Self {
		return self * self
	}
}

let i: Int = 8
print(i.squared())

let j: UInt64 = 8
print(j.squared())


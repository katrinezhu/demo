// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// Int, Float/Double, Bool, String, Array, Dictionary
var intVar: Int = 100
var intVar2 = 200

intVar + intVar2
++intVar
intVar & intVar2
~intVar

1_000_000_000
// bin, oct, hex
var bin = 0b00101010101
var oct = 0o12334
var hex = 0x000ffff

var floatVar = 10.0 // double
var floatVar2 = Float(100)

floatVar2 % 2

var floatVar3 = 1e10

// YES NO
var boolVar = false // true
var boolVar2 = true

boolVar && boolVar2
boolVar || boolVar2

boolVar == 0
boolVar2 == 0

boolVar.bridgeToObjectiveC()

var strVar = "a" + "bc"
var strVar2 = "abc"

//[strVar isEqualToString:@""]
//
strVar == strVar2
strVar > strVar2
strVar

var apples = 10

var strVar3 = "I have \(apples) apples"
// String

var strVar4 = strVar3.bridgeToObjectiveC()
var strVar5 = strVar4 as NSString
// NSString
strVar5.length
strVar5.substringFromIndex(2)

// String -- NSString Array -- NSArray Dictionary -- NSDictionary

// array
var arr1 = [ 1, 2, 3, 4 ]
arr1.append(5)
arr1.insert(0, atIndex: 0)
arr1
arr1 += [ 6, 7, 8 ]
arr1[0...4]
arr1[0] = -1
// oc: id
var arr2: [Int] = []
var arr3 = Array<Int>(count: 10, repeatedValue: 0)
// dictionary key-value pair c++/java: Map
// objc @{  }
var dict1 = [ "apple": "iPhone" ]
dict1["apple"]!
dict1["samsung"] = "Galaxy Note"
dict1
dict1["apple"] = nil
dict1

arr2.removeAll(keepCapacity: false)
dict1.removeAll(keepCapacity: false)

// if else for while do while switch

var randomNumber = arc4random()

if randomNumber % 2 == 0 {
    "x"
} else {
    "y"
}

// for
// for-condition-increment
for var i=0; i<10; ++i {
    i
}
// for in
// [0, 10)
// [0, 10]
// 0..10
for i in 0..<10 {
    i
}

var b = 0
while b < 10 {
    ++b
    println(b)
}
// switch
// int, char
var iPhone = "iPhone"
switch iPhone {
    case "Nexus":
        "a"
    case "iPhone":
        "b"
    fallthrough
    case "Lumia":
        "c"
default:break
}

// func
func foo() {
    println("aa")
}

foo()

func add(a: Int, b: Int) -> Int {
    return a + b
}
add(10, 20)

func add2(#a: Int, #b: Int) -> Int {
    return a + b
}
add2(a: 10, b: 20)

// tuple (1, 2, 3, 4)
func sort(a: Int, b: Int) -> (max: Int, min: Int) {
    let maxNum = max(a, b)
    let minNum = min(a, b)
    return (maxNum, minNum)
}
let sorted = sort(100, 200)
sorted
sorted.max
sorted.min
let (maxNum, minNum) = sort(100, 200)
maxNum
minNum
// inout 值拷贝
func swap(inout a: Int, inout b: Int) {
    a ^= b
    b ^= a
    a ^= b
}
var numbera = 0
var numberb = 1
swap(&numbera, &numberb)
numbera
numberb
// closure lambda blocks
// sort
var array = [ -1, 0, 2, 99, 24 ]
sort(&array, {(a: Int, b: Int) in return a > b })
array
sort(&array) {
    (a: Int, b: Int) in
    return a < b
}
array
sort(&array) {
    a, b in
    return a > b
}
array
sort(&array) {
    a, b in a < b
}
sort(&array) {
    return $0 > $1
}
sort(&array, <)

// class
class 🐶 {
    var age = 10
    var name = "Goofy"
    
    // oc initWithXXX yyy
    init() {
        
    }
    
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
    
    func sayHi() {
        println(name + ": Hi, I'm \(age) years old")
    }
}

var goofy = 🐶()
goofy.sayHi()
var wangcai = 🐶(age: 12, name: "WangCai")
wangcai.sayHi()

// struct
// int, float
struct Screen {
    var width = 100
    var height = 200
}

// objc -- categroy
extension Int {
    var half: Double {
        return Double(self) / 2
    }
}
100.half

// subscript []
class MyArray {
    var data = [1, 2, 3, 4, 5]
    
    subscript (index: Int) -> Double {
        return Double(data[index]) / 2.0
    }
    
    subscript (a: Int, b: Int) -> Int {
        var sum = 0
        for i in a...b {
            sum += i
        }
        return sum
    }
}

var myarr = MyArray()
myarr.data
myarr[0]
myarr[0, 4]

// Optional Value
var optionalStr: String?
var sss: Optional<String>
optionalStr
var dict5 = ["key": "value"]
dict5["key"]

var boolOptional: Bool? = false

// some: false
if boolOptional! {
   "aa"
}
// ? <--> !
func - (a: Int, b: Int) -> Int {
    return a + b
}
10 - 10











































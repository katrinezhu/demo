// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var color = UIColor.purpleColor()

var attString = NSAttributedString(string: "Hello, Swift", attributes: [
    NSForegroundColorAttributeName: color,
    NSBackgroundColorAttributeName: UIColor.redColor(),
    NSFontAttributeName: UIFont.systemFontOfSize(100)
    ])

var point = CGPoint(x: 0, y: 0)
var size = CGSize(width: 100, height: 400)
var rect = CGRect(x: point.x, y: point.y, width: size.width, height: size.height)

// bezier path
var bezier = UIBezierPath()
bezier.moveToPoint(CGPointZero)
bezier.addCurveToPoint(CGPoint(x: 210, y: 0), controlPoint1: CGPoint(x: 70, y: 200), controlPoint2: CGPoint(x: 140, y: -400))

var url = NSURL(string: "http://www.qq.com")

for i in -100..<100 {
    i * i * i
    // f(x) = x
}

for x in 0...100 {
    sin(Double(x) * M_PI / 16) * Double(x)
}

// n
// 1, 2
// f(n) = ...
// n = 1, 1
// n = 2, 2
// 10
// f(n) = f(n - 1) + f(n - 2)
// f(1) = 1, f(2) = 2
// f(0) = f(2) - f(1) = 1

var numbers = Array<Int>(count: 100, repeatedValue: 0)

func fibs(n: Int) -> Int {
    
    if numbers[n] == 0 {
        numbers[n] = (n == 0 || n == 1) ? 1: fibs(n-1) + fibs(n-2)
    }
    
    return numbers[n]
}
fibs(15)
// f(n) --> f(n - 2)
// f(n - 1) --> f(n - 2)























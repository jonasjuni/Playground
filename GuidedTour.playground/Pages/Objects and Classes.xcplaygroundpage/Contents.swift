//: ## Objects and Classes
//:
//: Use `class` followed by the class’s name to create a class. A property declaration in a class is written the same way as a constant or variable declaration, except that it’s in the context of a class. Likewise, method and function declarations are written the same way.
//:
class Shape {
    var numberOfSides = 0
    let classConstant = "test"
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

//: - Experiment:
//: Add a constant property with `let`, and add another method that takes an argument.
//:
//: Create an instance of a class by putting parentheses after the class name. Use dot syntax to access the properties and methods of the instance.
//:
var shape = Shape()
shape.numberOfSides = 700
var shapeDescription = shape.simpleDescription()
//: This version of the `Shape` class is missing something important: an initializer to set up the class when an instance is created. Use `init` to create one.
//:
class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
       self.name = name
    }

    func simpleDescription() -> String {
       return "A shape with \(numberOfSides) sides."
    }
}

let testNamedShape = NamedShape(name: "Round")
testNamedShape.simpleDescription()
//: Notice how `self` is used to distinguish the `name` property from the `name` argument to the initializer. The arguments to the initializer are passed like a function call when you create an instance of the class. Every property needs a value assigned—either in its declaration (as with `numberOfSides`) or in the initializer (as with `name`).
//:
//: Use `deinit` to create a deinitializer if you need to perform some cleanup before the object is deallocated.
//:
//: Subclasses include their superclass name after their class name, separated by a colon. There’s no requirement for classes to subclass any standard root class, so you can include or omit a superclass as needed.
//:
//: Methods on a subclass that override the superclass’s implementation are marked with `override`—overriding a method by accident, without `override`, is detected by the compiler as an error. The compiler also detects methods with `override` that don’t actually override any method in the superclass.
//:
class Square: NamedShape {
    var sideLength: Double

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }

    func area() -> Double {
        return sideLength * sideLength
    }

    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

class Circle: NamedShape {
    var radius: Double
    
    init(name: String, radius: Double){
        self.radius = radius
        super.init(name: name)
//        numberOfSides = 0
    }
    override func simpleDescription() -> String {
        return "The \(name) with a radius of \(radius)"
    }
    
    func area() -> Double {
        return Double.pi * radius * radius
    }
}

let circle = Circle(name: "Great Circle", radius: 5)
circle.area()
circle.simpleDescription()


//: - Experiment:
//: Make another subclass of `NamedShape` called `Circle` that takes a radius and a name as arguments to its initializer. Implement an `area()` and a `simpleDescription()` method on the `Circle` class.
//:
//: In addition to simple properties that are stored, properties can have a getter and a setter.
//:
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }

    var perimeter: Double {
        get {
             return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }

    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
triangle.perimeter = 18
print(triangle.sideLength)

//: In the setter for `perimeter`, the new value has the implicit name `newValue`. You can provide an explicit name in parentheses after `set`.
//:
//: Notice that the initializer for the `EquilateralTriangle` class has three different steps:
//:
//: 1. Setting the value of properties that the subclass declares.
//:
//: 1. Calling the superclass’s initializer.
//:
//: 1. Changing the value of properties defined by the superclass. Any additional setup work that uses methods, getters, or setters can also be done at this point.
//:
//: If you don’t need to compute the property but still need to provide code that’s run before and after setting a new value, use `willSet` and `didSet`. The code you provide is run any time the value changes outside of an initializer. For example, the class below ensures that the side length of its triangle is always the same as the side length of its square.
//:
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)
print(triangleAndSquare.square.sideLength)

//: When working with optional values, you can write `?` before operations like methods, properties, and subscripting. If the value before the `?` is `nil`, everything after the `?` is ignored and the value of the whole expression is `nil`. Otherwise, the optional value is unwrapped, and everything after the `?` acts on the unwrapped value. In both cases, the value of the whole expression is an optional value.
//:
var optionalSquare: Square?
let sideLength = optionalSquare?.sideLength

class Person {
    let name: String
    let age: Int
    
    init(name: String, age: Int){
        self.name = name
        self.age = age
    }
    func greet() -> String{
        return "Hello I'm \(name)!"
    }
}

class Employee: Person {
    let id: String
    private var _salary: Double = 0
    init(name:String, age: Int, id: String) {
        self.id = id
        super.init(name: name, age: age)
    }
    var tax: Double {
        get {
            return _salary * 0.6
        }
    }
    var salary: Double{
        get {
            return _salary
        }
        set {
            _salary = newValue
        }
    }
    override func greet() -> String {
        return "\(super.greet()) My id is \(id)"
    }
}

let employee = Employee(name: "Jonas", age: 33, id: "21312323")
employee.greet()
employee.salary
employee.salary = 350
employee.tax


//: [Previous](@previous) | [Next](@next)

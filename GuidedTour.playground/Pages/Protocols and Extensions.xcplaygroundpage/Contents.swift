//: ## Protocols and Extensions
//:
//: Use `protocol` to declare a protocol.
//:
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
    var id: Int {get}
}

//: Classes, enumerations, and structures can all adopt protocols.
//:
class SimpleClass: ExampleProtocol {
    var id: Int = 43
    var simpleDescription: String = " A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}//Type 'SimpleClass' does not conform to protocol 'ExampleProtocol'
var a = SimpleClass()
a.adjust()
a.id = 23
a.id
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    let id: Int = 32
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription


//: - Experiment:
//: Add another requirement to `ExampleProtocol`. What changes do you need to make to `SimpleClass` and `SimpleStructure` so that they still conform to the protocol?
//:
//: Notice the use of the `mutating` keyword in the declaration of `SimpleStructure` to mark a method that modifies the structure. The declaration of `SimpleClass` doesn’t need any of its methods marked as mutating because methods on a class can always modify the class.
//:
//: Use `extension` to add functionality to an existing type, such as new methods and computed properties. You can use an extension to add protocol conformance to a type that’s declared elsewhere, or even to a type that you imported from a library or framework.
//:
extension Int: ExampleProtocol {
    var id: Int {
        return 1
    }
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
var number: Int = 7
print(7.simpleDescription)
number.simpleDescription
number.adjust()
number.id

extension Double {
    /// Return the absolute value of a Double
    var absoluteValue: Double {
        return self.magnitude
    }
}
let absoluteValue = (-7.5).absoluteValue

//: - Experiment:
//: Write an extension for the `Double` type that adds an `absoluteValue` property.
//:
//: You can use a protocol name just like any other named type—for example, to create a collection of objects that have different types but that all conform to a single protocol. When you work with values whose type is a protocol type, methods outside the protocol definition aren’t available.
//:
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
//print(protocolValue.anotherProperty)  // Uncomment to see the error
//Value of type 'ExampleProtocol' has no member 'anotherProperty'
//: Even though the variable `protocolValue` has a runtime type of `SimpleClass`, the compiler treats it as the given type of `ExampleProtocol`. This means that you can’t accidentally access methods or properties that the class implements in addition to its protocol conformance.
//:


//: [Previous](@previous) | [Next](@next)

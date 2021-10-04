# Type Wrapper

A better solution than dealing with Any.Type directly. This library was made for [App Maker's Swift interpreter](http://github.com/App-Maker-Software/SwiftInterpreter).

Using `TypeWrapper` allows you to put complex types (such a generics or protocols with associate types) into a simple wrapper allowing you to still attempt to use underlying methods. This allows us to do robust work with types without the concrete type.

## Example from SwiftUI  

If we have a type `Any`, we can't know how to call shared methods on the protocol `View`.

```swift
var someView: Any = SwiftUI.Text("hello world")
if condition {
    someView = SwiftUI.Button("click me") { print("clicked") }
}
let redView = someView.foregroundColor(.red) // ❌ impossible to call without a cast...and we don't know if we have a button or a text
```

Solution with `TypeWrapper`:

```swift
// setup
extension TypeWrapper {
    func makeRed(_ someView: Any) throws -> AnyWithTypeWrapper {
        try self.attempt {
            ($0 as? _SwiftUIView)?.onReceive(input: someView)
        }
    }
}
protocol _SwiftUIView {
    func onReceive(input: Any) -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _SwiftUIView where Wrapped: View {
    public func onReceive(input: Any) -> AnyWithTypeWrapper {
        let view = input as! Wrapped
        let redView = view.foregroundColor(.red)
        return addTypeWrapper(redView)
    }
}


// usage
var anyWithTypeWrapper: AnyWithTypeWrapper = addTypeWrapper(SwiftUI.Text("hello world"))
if condition {
    anyWithTypeWrapper = addTypeWrapper(SwiftUI.Button("click me") { print("clicked") })
}
anyWithTypeWrapper = try anyWithTypeWrapper.typeWrapper.makeRed(anyWithTypeWrapper.any) // ✅ works no matter what type we put in...as long as it conforms to View
print(anyWithTypeWrapper.any) // raw value
print(anyWithTypeWrapper.typeWrapper) // type wrapper
```

You can see how this can be useful if you have an array of things of type `View` and you want to make changes without using `AnyView`:

```swift
var array: [AnyWithTypeWrapper] = ...

// make them all red without use of "AnyView"
for i in 0..<array.count {
    let el = array[i]
    array[i] = try el.typeWrapper.makeRed(el.any)
}
```

## Generics

Let's say we have this generic type:

```swift
public struct Example<T: FloatingPoint & ExpressibleByFloatLiteral> {
    let floatingPointValue: T
}
```
Usually we would need a type eraser if we'd want to work with different concrete implementations, but with `TypeWrapper` we can get around that. First we register our generic values:

```swift
extension Example: Register1Generic {
    public typealias Generic0 = T
}
```

Here we used `Register1Generic`, because we have one generic...but we could have also done `Register2Generics` or even `Register5Generics` which would give us more typealiases to map to our generic types. Then to implement a method for `TypeWrapper`, we do the following: 

```swift
extension TypeWrapper {
    func add12Point4ToGenericType(_ any: Any) throws -> AnyWithTypeWrapper {
        try self.attempt {
            ($0 as? _CustomTypeWithGenericFloatingPoint)?.onReceive(input: any)
        }
    }
}
protocol _Example {
    func onReceive(input: Any) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _Example where Wrapped == Example<Generics.Generic0>, Generics.Generic0: FloatingPoint & ExpressibleByFloatLiteral {
    public func onReceive(input: Any) throws -> AnyWithTypeWrapper {
        let floatingPointValue = (input as! Wrapped).floatingPointValue
        let twelvePoint4: Generics.Generic0 = 12.4
        let result = floatingPointValue + twelvePoint4
        return addTypeWrapper(result)
    }
}
```

## Example Implementations

Goto the [example implementations folder](https://github.com/App-Maker-Software/TypeWrapper/tree/main/Tests/TypeWrapperTests/ExampleImplementations) to see how to easily implement this for a type you wish to wrap in your code. 

## Sources

Implementation inspired by: https://forums.swift.org/t/test-if-a-type-conforms-to-a-non-existential-protocol/35479/40

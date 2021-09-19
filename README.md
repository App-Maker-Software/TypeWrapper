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
        try self.send(someView, as: {
            ($0 as? _SwiftUIView)?.onReceive(input:)
        })
    }
}
protocol _SwiftUIView {
    func onReceive(input: Any) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _SwiftUIView where Wrapped: View {
    public func onReceive(input: Any) throws -> AnyWithTypeWrapper {
        let redView = (input as! Wrapped).foregroundColor(.red)
        return addTypeWrapper(redView)
    }
}


// usage
var (any, typeWrapper): (Any, TypeWrapper) = addTypeWrapper(SwiftUI.Text("hello world"))
if condition {
    (any, typeWrapper) = addTypeWrapper(SwiftUI.Button("click me") { print("clicked") })
}
let (redView, newTypeWrapper): (Any, TypeWrapper) = try typeWrapper.makeRed(any) // ✅ works no matter what type we put in...as long as it conforms to View
```


## Example Implementations

Goto the [example implementations folder](https://github.com/App-Maker-Software/TypeWrapper/tree/main/Tests/TypeWrapperTests/ExampleImplementations) to see how to easily implement this for a type you wish to wrap in your code. 

Help from: https://forums.swift.org/t/test-if-a-type-conforms-to-a-non-existential-protocol/35479/40

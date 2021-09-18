# Type Wrapper

A better solution than dealing with Any.Type directly. This library was made for [App Maker's Swift interpreter](http://github.com/App-Maker-Software/SwiftInterpreter).

Using `TypeWrapper` allows you to put complex types (such a generics or protocols with associate types) into a simple wrapper allowing you to still attempt to use underlying methods.


## Example from SwiftUI  

If we have a type `Any`, we can't know how to call shared methods on the protocol `View`

```swift
var someView: Any = SwiftUI.Text("hello world")
if condition {
    someView = SwiftUI.Button("click me") { print("clicked") }
}
let redView = someView.foregroundColor(.red) // ❌ impossible to call without a cast...and we don't know if we have a button or a text
```

Solution:

```swift
// setup
extension AttemptIfConforms where Wrapped: View {
    func makeRed(view: Wrapped) -> some View {
        return view.foregroundColor(.red)
    }
}

// usage
var (someView, typeWrapper): (Any, TypeWrapper) = SwiftUI.Text("hello world").wrapType()
if condition {
    (someView, typeWrapper) = SwiftUI.Button("click me") { print("clicked") }.wrapType()
}
typeWrapper.attempt(
let redView = someView.foregroundColor(.red) // ❌ impossible to call without a cast...and we don't know if we have a button or a text
```


var (someView, typeWrapper): (Any, TypeWrapper) = addTypeWrapper(SwiftUI.Text("hello world"))

Help from: https://forums.swift.org/t/test-if-a-type-conforms-to-a-non-existential-protocol/35479/40

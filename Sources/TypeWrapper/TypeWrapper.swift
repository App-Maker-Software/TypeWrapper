
public typealias TypeOnRecieve = (_ input: Any) throws -> AnyWithTypeWrapper
public typealias TypeOnRecieve2 = (_ input: Any) throws -> TypeWrapper

public struct TypeWrapper {
    // public
    public func send(_ input: Any, as toKnown: (Any) -> TypeOnRecieve?) throws -> AnyWithTypeWrapper {
        try _send(input, toKnown)
    }
    public func sendReturnOnlyType(_ input: Any, as toKnown: (Any) -> TypeOnRecieve2?) throws -> TypeWrapper {
        try _sendReturnOnlyType(input, toKnown)
    }
    #if DEBUG
    public let _rawType: Any.Type
    #endif
    
    // private
    private let _send: (Any, (Any) -> TypeOnRecieve?) throws -> AnyWithTypeWrapper
    private let _sendReturnOnlyType: (Any, (Any) -> TypeOnRecieve2?) throws -> TypeWrapper
    
    // inits
    public init<Wrapped>(withType type: Wrapped.Type) {
        self._send = HandleTypeWrapper<Wrapped>().send(_:toKnown:)
        self._sendReturnOnlyType = HandleTypeWrapper<Wrapped>().sendReturnOnlyType(_:toKnown:)
        #if DEBUG
        self._rawType = Wrapped.self
        #endif
    }
    public init<Wrapped: _GenericRegister>(withType type: Wrapped.Type) {
        self._send = HandleTypeWrapper<Wrapped>().send(_:toKnown:)
        self._sendReturnOnlyType = HandleTypeWrapper<Wrapped>().sendReturnOnlyType(_:toKnown:)
        #if DEBUG
        self._rawType = Wrapped.self
        #endif
    }
}

public func addTypeWrapper<T>(_ value: T) -> (Any, TypeWrapper) {
    return (value, .init(withType: T.self))
}
public func addTypeWrapper<T: _GenericRegister>(_ value: T) -> (Any, TypeWrapper) {
    return (value, .init(withType: T.self))
}

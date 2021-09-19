
public typealias TypeOnRecieve = (_ info: Any) throws -> AnyWithTypeWrapper

public struct TypeWrapper {
    // public
    public func send(_ info: Any, as toKnown: (Any) -> TypeOnRecieve?) throws -> AnyWithTypeWrapper {
        try _send(info, toKnown)
    }
    #if DEBUG
    public let _rawType: Any.Type
    #endif
    
    // private
    private let _send: (Any, (Any) -> TypeOnRecieve?) throws -> AnyWithTypeWrapper
    
    // inits
    public init<Wrapped>(withType type: Wrapped.Type) {
        self._send = HandleTypeWrapper<Wrapped>().send(_:toKnown:)
        #if DEBUG
        self._rawType = Wrapped.self
        #endif
    }
    public init<Wrapped: _GenericRegister>(withType type: Wrapped.Type) {
        self._send = HandleTypeWrapper<Wrapped>().send(_:toKnown:)
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

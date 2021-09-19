
public typealias TypeOnRecieve = (_ input: Any) throws -> AnyWithTypeWrapper

public struct TypeWrapper {
    // public
    public func send(_ attempter: (Any) -> AnyWithTypeWrapper?) throws -> AnyWithTypeWrapper {
        try _send(attempter)
    }
    #if DEBUG
    public let _rawType: Any.Type
    #endif
    
    // private
    private let _send: ((Any) -> AnyWithTypeWrapper?) throws -> AnyWithTypeWrapper
    
    // inits
    public init<Wrapped>(withType type: Wrapped.Type) {
        self._send = HandleTypeWrapper<Wrapped>().send(attempter:)
        #if DEBUG
        self._rawType = Wrapped.self
        #endif
    }
    public init<Wrapped: _GenericRegister>(withType type: Wrapped.Type) {
        self._send = HandleTypeWrapper<Wrapped>().send(attempter:)
        #if DEBUG
        self._rawType = Wrapped.self
        #endif
    }
}

public func addTypeWrapper<T>(_ value: T) -> AnyWithTypeWrapper {
    return AnyWithTypeWrapper(
        any: value,
        typeWrapper: .init(withType: T.self)
    )
}
public func addTypeWrapper<T: _GenericRegister>(_ value: T) -> AnyWithTypeWrapper {
    return AnyWithTypeWrapper(
        any: value,
        typeWrapper: .init(withType: T.self)
    )
}

public struct AnyWithTypeWrapper {
    public let any: Any
    public let typeWrapper: TypeWrapper
}

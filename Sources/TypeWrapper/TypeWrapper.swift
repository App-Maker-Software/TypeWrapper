
public typealias TypeOnRecieve = (_ input: Any) throws -> AnyWithTypeWrapper
public typealias TypeOnRecieve2 = (_ input: Any) throws -> TypeWrapper

public struct TypeWrapper {
    // public
    public func attempt(_ attempter: (Any) throws -> AnyWithTypeWrapper?) throws -> AnyWithTypeWrapper {
        try _attempt(attempter)
    }
    public func attemptOnlyValue(_ attempter: (Any) throws -> Any?) throws -> Any {
        try _attemptOnlyValue(attempter)
    }
    public func attemptOnlyType(_ attempter: (Any) throws -> TypeWrapper?) throws -> TypeWrapper {
        try _attemptOnlyType(attempter)
    }
    #if DEBUG
    public let _rawType: Any.Type
    #endif
    
    // private
    private let _attempt: ((Any) throws -> AnyWithTypeWrapper?) throws -> AnyWithTypeWrapper
    private let _attemptOnlyValue: ((Any) throws -> Any?) throws -> Any
    private let _attemptOnlyType: ((Any) throws -> TypeWrapper?) throws -> TypeWrapper
    
    // inits
    public init<Wrapped>(withType type: Wrapped.Type) {
        self._attempt = HandleTypeWrapper<Wrapped>().attempt(attempter:)
        self._attemptOnlyValue = HandleTypeWrapper<Wrapped>().attemptReturnOnlyValue(attempter:)
        self._attemptOnlyType = HandleTypeWrapper<Wrapped>().attemptReturnOnlyType(attempter:)
        #if DEBUG
        self._rawType = Wrapped.self
        #endif
    }
    public init<Wrapped: _GenericRegister>(withType type: Wrapped.Type) {
        self._attempt = HandleTypeWrapper<Wrapped>().attempt(attempter:)
        self._attemptOnlyValue = HandleTypeWrapper<Wrapped>().attemptReturnOnlyValue(attempter:)
        self._attemptOnlyType = HandleTypeWrapper<Wrapped>().attemptReturnOnlyType(attempter:)
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

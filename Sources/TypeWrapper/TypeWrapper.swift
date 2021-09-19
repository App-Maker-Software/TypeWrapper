
public typealias TypeOnRecieve = (_ input: Any) throws -> AnyWithTypeWrapper

public struct TypeWrapper {
    // public
    public func attempt(_ attempter: (Any) -> AnyWithTypeWrapper?) throws -> AnyWithTypeWrapper {
        try _attempt(attempter)
    }
    #if DEBUG
    /// debug only
    public let _rawType: Any.Type
    #endif
    
    // private
    private let _attempt: ((Any) -> AnyWithTypeWrapper?) throws -> AnyWithTypeWrapper
    
    // inits
    public init<Wrapped>(withType type: Wrapped.Type) {
        self._attempt = HandleTypeWrapper<Wrapped>().attempt(attempter:)
        #if DEBUG
        self._rawType = Wrapped.self
        #endif
    }
    public init<Wrapped: _GenericRegister>(withType type: Wrapped.Type) {
        self._attempt = HandleTypeWrapper<Wrapped>().attempt(attempter:)
        #if DEBUG
        self._rawType = type
        #endif
    }
    public init<InWrapped, OutWrapped>(withClosureType type: ((InWrapped) -> OutWrapped).Type) {
        self._attempt = HandleTypeWrapperClosure<InWrapped, OutWrapped>().attempt(attempter:)
        #if DEBUG
        self._rawType = type
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
public func addTypeWrapper<T, U>(_ value: @escaping (T) -> U) -> AnyWithTypeWrapper {
    return AnyWithTypeWrapper(
        any: value,
        typeWrapper: .init(withClosureType: ((T) -> U).self)
    )
}

public struct AnyWithTypeWrapper {
    public let any: Any
    public let typeWrapper: TypeWrapper
}

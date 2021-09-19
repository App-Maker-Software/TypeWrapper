//
//  AttemptIfConforms.swift
//  
//
//  Created by Joseph Hinkle on 9/18/21.
//

protocol AttemptIfConforms {
    associatedtype Wrapped
}

public struct AttemptIfConformsStruct<P: ProxyProtocol, G: _GenericRegister>: AttemptIfConforms {
    public typealias Wrapped = P.Wrapped
    public typealias Generics = G
    public init<T>(_ type: T.Type, _ genericRegister: Generics.Type) where P == Proxy<T> {}
}

public typealias AnyWithTypeWrapper = (Any, TypeWrapper)

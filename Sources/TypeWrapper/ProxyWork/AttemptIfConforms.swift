//
//  AttemptIfConforms.swift
//  
//
//  Created by Joseph Hinkle on 9/18/21.
//

public struct AttemptIfConformsStruct<P: ProxyProtocol, G: _GenericRegister> {
    public typealias Wrapped = P.Wrapped
    public typealias Generics = G
    public init<T>(_ type: T.Type, _ genericRegister: Generics.Type) where P == Proxy<T> {}
}

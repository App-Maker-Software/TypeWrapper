//
//  AttemptIfConforms.swift
//  
//
//  Created by Joseph Hinkle on 9/18/21.
//

protocol AttemptIfConforms {
    associatedtype Wrapped
//    func send(_ info: InfoToSendToConcreteType, to typeId: TypeId.Type) throws -> AnyWithTypeWrapper
}

public final class AttemptIfConformsStruct<P: ProxyProtocol>: AttemptIfConforms {
    typealias Wrapped = P.Wrapped
    public init<T>(_ type: T.Type) where P == Proxy<T> {}
}

public typealias AnyWithTypeWrapper = (Any, TypeWrapper)

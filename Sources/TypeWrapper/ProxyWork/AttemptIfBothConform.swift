//
//  AttemptIfBothConform.swift
//  
//
//  Created by Joseph Hinkle on 9/19/21.
//

struct AttemptIfBothConformStruct<P0: ProxyProtocol, P1: ProxyProtocol> {
    public typealias Wrapped0 = P0.Wrapped
    public typealias Wrapped1 = P1.Wrapped
    public init<T, U>(_ type0: T.Type, _ type1: T.Type) where P0 == Proxy<T>, P1 == Proxy<U> {}
}

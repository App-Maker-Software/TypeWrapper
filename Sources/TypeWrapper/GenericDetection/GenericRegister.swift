//
//  GenericRegister.swift
//  
//
//  Created by Joseph Hinkle on 9/18/21.
//

// a protocol used for self-reporting generics in a type
public protocol GenericRegister {
    associatedtype Generic0
    associatedtype Generic1
    associatedtype Generic2
    associatedtype Generic3
    associatedtype Generic4
}
//public extension GenericRegister {
//    typealias Generic0 = UnusedStub
//    typealias Generic1 = UnusedStub
//    typealias Generic2 = UnusedStub
//    typealias Generic3 = UnusedStub
//    typealias Generic4 = UnusedStub
//}
public enum NonGeneric: GenericRegister {
    public typealias Generic0 = UnusedStub
    public typealias Generic1 = UnusedStub
    public typealias Generic2 = UnusedStub
    public typealias Generic3 = UnusedStub
    public typealias Generic4 = UnusedStub
}

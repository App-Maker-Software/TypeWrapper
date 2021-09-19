//
//  GenericRegister.swift
//  
//
//  Created by Joseph Hinkle on 9/18/21.
//

// a protocol used for self-reporting generics in a type
public protocol _GenericRegister {
    associatedtype Generic0
    associatedtype Generic1
    associatedtype Generic2
    associatedtype Generic3
    associatedtype Generic4
}

// what a user will use to register their generics
public protocol Register1Generic: _GenericRegister where
    Generic1 == UnusedStub,
    Generic2 == UnusedStub,
    Generic3 == UnusedStub,
    Generic4 == UnusedStub {}
public protocol Register2Generics: _GenericRegister where
    Generic2 == UnusedStub,
    Generic3 == UnusedStub,
    Generic4 == UnusedStub {}
public protocol Register3Generics: _GenericRegister where
    Generic3 == UnusedStub,
    Generic4 == UnusedStub {}
public protocol Register4Generics: _GenericRegister where
    Generic4 == UnusedStub {}
public protocol Register5Generics: _GenericRegister {}

public enum NonGeneric: _GenericRegister {
    public typealias Generic0 = UnusedStub
    public typealias Generic1 = UnusedStub
    public typealias Generic2 = UnusedStub
    public typealias Generic3 = UnusedStub
    public typealias Generic4 = UnusedStub
}

// represents the absence of using a generic
public protocol UnusedStub {}

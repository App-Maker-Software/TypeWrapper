//
//  ConvenienceGenericRegisters.swift
//  
//
//  Created by Joseph Hinkle on 9/19/21.
//

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

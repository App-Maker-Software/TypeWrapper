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
    Generic4 == UnusedStub,
    Generic5 == UnusedStub,
    Generic6 == UnusedStub,
    Generic7 == UnusedStub,
    Generic8 == UnusedStub,
    Generic9 == UnusedStub {}
public protocol Register2Generics: _GenericRegister where
    Generic2 == UnusedStub,
    Generic3 == UnusedStub,
    Generic4 == UnusedStub,
    Generic5 == UnusedStub,
    Generic6 == UnusedStub,
    Generic7 == UnusedStub,
    Generic8 == UnusedStub,
    Generic9 == UnusedStub {}
public protocol Register3Generics: _GenericRegister where
    Generic3 == UnusedStub,
    Generic4 == UnusedStub,
    Generic5 == UnusedStub,
    Generic6 == UnusedStub,
    Generic7 == UnusedStub,
    Generic8 == UnusedStub,
    Generic9 == UnusedStub {}
public protocol Register4Generics: _GenericRegister where
    Generic4 == UnusedStub,
    Generic5 == UnusedStub,
    Generic6 == UnusedStub,
    Generic7 == UnusedStub,
    Generic8 == UnusedStub,
    Generic9 == UnusedStub {}
public protocol Register5Generics: _GenericRegister where
    Generic5 == UnusedStub,
    Generic6 == UnusedStub,
    Generic7 == UnusedStub,
    Generic8 == UnusedStub,
    Generic9 == UnusedStub {}
public protocol Register6Generics: _GenericRegister where
    Generic6 == UnusedStub,
    Generic7 == UnusedStub,
    Generic8 == UnusedStub,
    Generic9 == UnusedStub {}
public protocol Register7Generics: _GenericRegister where
    Generic7 == UnusedStub,
    Generic8 == UnusedStub,
    Generic9 == UnusedStub {}
public protocol Register8Generics: _GenericRegister where
    Generic8 == UnusedStub,
    Generic9 == UnusedStub {}
public protocol Register9Generics: _GenericRegister where
    Generic9 == UnusedStub {}

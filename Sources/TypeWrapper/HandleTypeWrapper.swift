//
//  HandleTypeWrapper.swift
//  
//
//  Created by Joseph Hinkle on 9/18/21.
//

public struct HandleTypeWrapper<Wrapped> {
    func attempt(attempter: (Any) -> AnyWithTypeWrapper?) throws -> AnyWithTypeWrapper {
        let attempt = AttemptIfConformsStruct(Wrapped.self, _NonGeneric.self)
        if let result = attempter(attempt) {
            return result
        } else {
            throw TypeWrapperError.mismatch
        }
    }
    func attempt(attempter: (Any) -> AnyWithTypeWrapper?) throws -> AnyWithTypeWrapper where Wrapped: _GenericRegister {
        let attempt = AttemptIfConformsStruct(Wrapped.self, Wrapped.self)
        if let result = attempter(attempt) {
            return result
        } else {
            throw TypeWrapperError.mismatch
        }
    }
}
public struct HandleTypeWrapperClosure<InWrapped, OutWrapped> {
    func attempt(attempter: (Any) -> AnyWithTypeWrapper?) throws -> AnyWithTypeWrapper {
        fatalError()
//        let attempt = AttemptIfConformsStruct(Wrapped.self, _NonGeneric.self)
//        if let result = attempter(attempt) {
//            return result
//        } else {
//            throw TypeWrapperError.mismatch
//        }
    }
    func attempt(attempter: (Any) -> AnyWithTypeWrapper?) throws -> AnyWithTypeWrapper where InWrapped: _GenericRegister {
        // ?? OutWrapped: _GenericRegister also?
        fatalError()
//        let attempt = AttemptIfConformsStruct(Wrapped.self, Wrapped.self)
//        if let result = attempter(attempt) {
//            return result
//        } else {
//            throw TypeWrapperError.mismatch
//        }
    }
}

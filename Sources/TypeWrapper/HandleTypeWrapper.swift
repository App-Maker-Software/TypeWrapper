//
//  HandleTypeWrapper.swift
//  
//
//  Created by Joseph Hinkle on 9/18/21.
//

public struct HandleTypeWrapper<Wrapped> {
    func attempt(attempter: (Any) throws -> AnyWithTypeWrapper?) throws -> AnyWithTypeWrapper {
        let attempt = AttemptIfConformsStruct(Wrapped.self, _NonGeneric.self)
        if let result = try attempter(attempt) {
            return result
        } else {
            throw TypeWrapperError.mismatch
        }
    }
    func attempt(attempter: (Any) throws -> AnyWithTypeWrapper?) throws -> AnyWithTypeWrapper where Wrapped: _GenericRegister {
        let attempt = AttemptIfConformsStruct(Wrapped.self, Wrapped.self)
        if let result = try attempter(attempt) {
            return result
        } else {
            throw TypeWrapperError.mismatch
        }
    }
    func attemptReturnOnlyType(attempter: (Any) throws -> TypeWrapper?) throws -> TypeWrapper {
        let attempt = AttemptIfConformsStruct(Wrapped.self, _NonGeneric.self)
        if let result = try attempter(attempt) {
            return result
        } else {
            throw TypeWrapperError.mismatch
        }
    }
    func attemptReturnOnlyType(attempter: (Any) throws -> TypeWrapper?) throws -> TypeWrapper where Wrapped: _GenericRegister {
        let attempt = AttemptIfConformsStruct(Wrapped.self, Wrapped.self)
        if let result = try attempter(attempt) {
            return result
        } else {
            throw TypeWrapperError.mismatch
        }
    }
}

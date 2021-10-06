//
//  HandleTypeWrapper.swift
//  
//
//  Created by Joseph Hinkle on 9/18/21.
//

public struct HandleTypeWrapper<Wrapped> {
    //
    // normal
    //
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
    //
    // return only value, in this case the attempter implementation must throw TypeWrapperError.mismatch itself if it wants to fail
    //
    func attemptReturnOnlyValue(attempter: (Any) throws -> Any) throws -> Any {
        let attempt = AttemptIfConformsStruct(Wrapped.self, _NonGeneric.self)
        return try attempter(attempt)
    }
    func attemptReturnOnlyValue(attempter: (Any) throws -> Any) throws -> Any where Wrapped: _GenericRegister {
        let attempt = AttemptIfConformsStruct(Wrapped.self, Wrapped.self)
        return try attempter(attempt)
    }
    //
    // return only type wrapper
    //
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

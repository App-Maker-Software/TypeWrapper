//
//  HandleTypeWrapper.swift
//  
//
//  Created by Joseph Hinkle on 9/18/21.
//

public struct HandleTypeWrapper<Wrapped> {
    func send(_ input: Any, toKnown: (Any) -> TypeOnRecieve?) throws -> AnyWithTypeWrapper {
        let attempt = AttemptIfConformsStruct(Wrapped.self, _NonGeneric.self)
        if let typeOnRecieve = toKnown(attempt) {
            return try typeOnRecieve(input)
        } else {
            throw TypeWrapperError.mismatch
        }
    }
    func send(_ input: Any, toKnown: (Any) -> TypeOnRecieve?) throws -> AnyWithTypeWrapper where Wrapped: _GenericRegister {
        let attempt = AttemptIfConformsStruct(Wrapped.self, Wrapped.self)
        if let typeOnRecieve = toKnown(attempt) {
            return try typeOnRecieve(input)
        } else {
            throw TypeWrapperError.mismatch
        }
    }
}

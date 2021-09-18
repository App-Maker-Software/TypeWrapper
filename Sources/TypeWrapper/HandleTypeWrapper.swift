//
//  HandleTypeWrapper.swift
//  
//
//  Created by Joseph Hinkle on 9/18/21.
//

public struct HandleTypeWrapper<Wrapped> {
    func send(_ info: Any, toKnown: (Any) -> TypeOnRecieve?) throws -> AnyWithTypeWrapper {
        let attempt = AttemptIfConformsStruct(Wrapped.self)
        if let typeOnRecieve = toKnown(attempt) {
            return try typeOnRecieve(info)
        } else {
            throw TypeWrapperError.mismatch
        }
    }
}

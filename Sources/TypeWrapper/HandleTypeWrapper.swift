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
    // if we are a generic builder
    func add(_ type: TypeWrapper) where Wrapped: GenericBuilder {
        
    }
}

final class GBAdderStep1 {
    func addGB<T: GenericBuilder>(gb: T) -> GBAdderStep2<T> {
        GBAdderStep2(gb: gb)
    }
}
final class GBAdderStep2<GB: GenericBuilder> {
    var gb: GB
    func addType<T>(type: T.Type) -> AnyWithTypeWrapper {
        return gb.add(type: type)
    }
    init(gb: GB) {
        self.gb = gb
    }
}

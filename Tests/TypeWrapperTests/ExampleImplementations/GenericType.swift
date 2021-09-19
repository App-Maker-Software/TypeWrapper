//
//  File.swift
//  
//
//  Created by Joseph Hinkle on 9/19/21.
//

import TypeWrapper

//
// register as generic
//
public struct CustomTypeWithGenericFloatingPoint<T: FloatingPoint & ExpressibleByFloatLiteral> {
    let floatingPointValue: T
}

extension CustomTypeWithGenericFloatingPoint: Register1Generic {
    public typealias Generic0 = T
}

//
// implement for generic
//
extension TypeWrapper {
    func add12Point4ToGenericType(_ any: Any) throws -> AnyWithTypeWrapper {
        try self.send(any, as: {
            ($0 as? _CustomTypeWithGenericFloatingPoint)?.onReceive(input:)
        })
    }
}
protocol _CustomTypeWithGenericFloatingPoint {
    func onReceive(input: Any) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _CustomTypeWithGenericFloatingPoint where Wrapped == CustomTypeWithGenericFloatingPoint<Generics.Generic0> {
    public func onReceive(input: Any) throws -> AnyWithTypeWrapper {
        let floatingPointValue = (input as! Wrapped).floatingPointValue
        let twelvePoint4: Generics.Generic0 = 12.4
        let result = floatingPointValue + twelvePoint4
        return addTypeWrapper(result)
    }
}

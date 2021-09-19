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

extension CustomTypeWithGenericFloatingPoint: GenericRegister {
    public typealias Generic0 = T
    public typealias Generic1 = UnusedStub
    public typealias Generic2 = UnusedStub
    public typealias Generic3 = UnusedStub
    public typealias Generic4 = UnusedStub
}

//
// add method to generic
//
extension TypeWrapper {
    func add12Point4ToGenericType(_ any: Any) throws -> AnyWithTypeWrapper {
        try self.send(any, as: {
            ($0 as? _CustomTypeWithGenericFloatingPoint)?.onReceive(info:)
        })
    }
}
protocol _CustomTypeWithGenericFloatingPoint {
    func onReceive(info: Any) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _CustomTypeWithGenericFloatingPoint where Wrapped == CustomTypeWithGenericFloatingPoint<Generics.Generic0>, Generics.Generic0: FloatingPoint & ExpressibleByFloatLiteral {
    public func onReceive(info: Any) throws -> AnyWithTypeWrapper {
        let floatingPointValue = (info as! Wrapped).floatingPointValue
        let twelvePoint4: Generics.Generic0 = 12.4
        let result = floatingPointValue + twelvePoint4
        return addTypeWrapper(result)
    }
}

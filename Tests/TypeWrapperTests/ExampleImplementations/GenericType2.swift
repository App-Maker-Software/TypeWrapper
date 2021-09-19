//
//  GenericType2.swift
//  
//
//  Created by Joseph Hinkle on 9/19/21.
//

import TypeWrapper
import SwiftUI

//
// register as generic
//
public struct GenericFuncsTest<T: ExpressibleByFloatLiteral, U: View> {
    let value: T
    let view: U
}

extension GenericFuncsTest: Register2Generics {
    public typealias Generic0 = T
    public typealias Generic1 = U
}
//
// implement for generic
//
extension TypeWrapper {
    func runGenericFunc(funcName: String, args: [Any]) throws -> AnyWithTypeWrapper {
        try self.send(Run_GenericFuncsTest_Args(funcName: funcName, args: args), as: {
            ($0 as? _GenericFuncsTest)?.onReceive(input:)
        })
    }
}
struct Run_GenericFuncsTest_Args {
    let funcName: String
    let args: [Any]
}
protocol _GenericFuncsTest {
    func onReceive(input: Any) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _GenericFuncsTest where Wrapped == GenericFuncsTest<Generics.Generic0, Generics.Generic1> {
    public func onReceive(input: Any) throws -> AnyWithTypeWrapper {
        let info = input as! Run_GenericFuncsTest_Args
        if let arg1: Generics.Generic0 = info.args.first as? Generics.Generic0,
           let arg2: Generics.Generic1 = info.args.dropFirst().first as? Generics.Generic1 {
            let result = Wrapped.init(value: arg1, view: arg2)
            return addTypeWrapper(result)
        }
        fatalError()
//
//        let floatingPointValue = (input as! Wrapped).floatingPointValue
//        let twelvePoint4: Generics.Generic0 = 12.4
//        let result = floatingPointValue + twelvePoint4
//        return addTypeWrapper(result)
    }
}

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
        try self.attempt {
            ($0 as? _GenericFuncsTest)?.onReceive(input: Run_GenericFuncsTest_Args(funcName: funcName, args: args))
        }
    }
}
struct Run_GenericFuncsTest_Args {
    let funcName: String
    let args: [Any]
}
protocol _GenericFuncsTest {
    func onReceive(input: Run_GenericFuncsTest_Args) -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _GenericFuncsTest where Wrapped == GenericFuncsTest<Generics.Generic0, Generics.Generic1> {
    func onReceive(input: Run_GenericFuncsTest_Args) -> AnyWithTypeWrapper {
        if let arg1: Generics.Generic0 = input.args.first as? Generics.Generic0,
           let arg2: Generics.Generic1 = input.args.dropFirst().first as? Generics.Generic1 {
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

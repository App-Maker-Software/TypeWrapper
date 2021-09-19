//
//  BuilderExample.swift
//  
//
//  Created by Joseph Hinkle on 9/20/21.
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
    func attemptInit(args: AttemptInitArgs) throws -> AnyWithTypeWrapper {
        try self.attempt {
            ($0 as? _GenericFuncsTest)?.onReceive(input: args)
        }
    }
}
struct AttemptInitArgs {
    let args: [Any]
}
protocol _GenericFuncsTest {
    func onReceive(input: AttemptInitArgs) -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _GenericFuncsTest where Wrapped: _GenericRegister, Generics.Generic0: ExpressibleByFloatLiteral, Generics.Generic1: View {
    func onReceive(input: AttemptInitArgs) -> AnyWithTypeWrapper {
        if let arg1: Generics.Generic0 = input.args.first as? Generics.Generic0,
           let arg2: Generics.Generic1 = input.args.dropFirst().first as? Generics.Generic1 {
            let result = GenericFuncsTest.init(value: arg1, view: arg2)
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

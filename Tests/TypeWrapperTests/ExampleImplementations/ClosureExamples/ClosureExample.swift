//
//  ClosureExample.swift
//  
//
//  Created by Joseph Hinkle on 9/20/21.
//

import TypeWrapper

extension TypeWrapper {
    func runClosure(with any: Any) throws -> AnyWithTypeWrapper {
        try self.attempt {
            ($0 as? _MyClosure)?.runClosure(input: any)
        }
    }
}
protocol _MyClosure {
    func runClosure(input: Any) -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _MyClosure where Wrapped == Double {
    public func runClosure(input: Any) -> AnyWithTypeWrapper {
        let double = input as! Double + 7
        return addTypeWrapper(double)
    }
}

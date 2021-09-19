//
//  SimpleTypes.swift
//  
//
//  Created by Joseph Hinkle on 9/19/21.
//

import TypeWrapper

//
// implement for simple type (int)
//
extension TypeWrapper {
    func addSevenToInt(_ anyInt: Any) throws -> AnyWithTypeWrapper {
        try self.send(anyInt, as: {
            ($0 as? _SwiftInt)?.onReceive(input:)
        })
    }
}
protocol _SwiftInt {
    func onReceive(input: Any) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _SwiftInt where Wrapped == Int {
    public func onReceive(input: Any) throws -> AnyWithTypeWrapper {
        let int = input as! Int + 7
        return addTypeWrapper(int)
    }
}
//
// implement for simple type (double)
//
extension TypeWrapper {
    func addSevenToDouble(_ anyDouble: Any) throws -> AnyWithTypeWrapper {
        try self.send(anyDouble, as: {
            ($0 as? _SwiftDouble)?.onReceive(input:)
        })
    }
}
protocol _SwiftDouble {
    func onReceive(input: Any) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _SwiftDouble where Wrapped == Double {
    public func onReceive(input: Any) throws -> AnyWithTypeWrapper {
        let double = input as! Double + 7
        return addTypeWrapper(double)
    }
}

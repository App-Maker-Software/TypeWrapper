//
//  SimpleTypes.swift
//  
//
//  Created by Joseph Hinkle on 9/19/21.
//

import TypeWrapper

//
// add method to int
//
extension TypeWrapper {
    func addSevenToInt(_ anyInt: Any) throws -> AnyWithTypeWrapper {
        try self.send(anyInt, as: {
            ($0 as? _SwiftInt)?.onReceive(info:)
        })
    }
}
protocol _SwiftInt {
    func onReceive(info: Any) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _SwiftInt where Wrapped == Int {
    public func onReceive(info: Any) throws -> AnyWithTypeWrapper {
        let int = info as! Int + 7
        return addTypeWrapper(int)
    }
}
//
// add method to double
//
extension TypeWrapper {
    func addSevenToDouble(_ anyDouble: Any) throws -> AnyWithTypeWrapper {
        try self.send(anyDouble, as: {
            ($0 as? _SwiftDouble)?.onReceive(info:)
        })
    }
}
protocol _SwiftDouble {
    func onReceive(info: Any) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _SwiftDouble where Wrapped == Double {
    public func onReceive(info: Any) throws -> AnyWithTypeWrapper {
        let double = info as! Double + 7
        return addTypeWrapper(double)
    }
}

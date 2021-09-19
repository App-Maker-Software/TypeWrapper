//
//  MoreOptions.swift
//  
//
//  Created by Joseph Hinkle on 9/19/21.
//

import TypeWrapper

//
// implement for simple type (Bool) with more options
//
extension TypeWrapper {
    func boolMoreOptions(_ options: _BoolExtraOptions) throws -> AnyWithTypeWrapper {
        try self.send(options, as: {
            ($0 as? _Bool)?.onReceive(input:)
        })
    }
}
protocol _Bool {
    func onReceive(input: Any) throws -> AnyWithTypeWrapper
}
struct _BoolExtraOptions {
    let someBool: Any
    let otherBool: Any
    let op: String
}
extension AttemptIfConformsStruct: _Bool where Wrapped == Bool {
    public func onReceive(input: Any) throws -> AnyWithTypeWrapper {
        let options = input as! _BoolExtraOptions
        if let someBool: Bool = options.someBool as? Bool,
           let otherBool: Bool = options.otherBool as? Bool {
            if options.op == "||" {
                let result = someBool || otherBool
                return addTypeWrapper(result)
            } else if options.op == "&&" {
                let result = someBool && otherBool
                return addTypeWrapper(result)
            } else {
                fatalError("bad op")
            }
        } else {
            fatalError("bad data")
        }
    }
}

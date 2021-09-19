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
        try self.send {
            ($0 as? _Bool)?.onReceive(options: options)
        }
    }
}
protocol _Bool {
    func onReceive(options: _BoolExtraOptions) -> AnyWithTypeWrapper
}
struct _BoolExtraOptions {
    let someBool: Any
    let otherBool: Any
    let op: String
}
extension AttemptIfConformsStruct: _Bool where Wrapped == Bool {
    func onReceive(options: _BoolExtraOptions) -> AnyWithTypeWrapper {
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

//
//  KnownConformance.swift
//  
//
//  Created by Joseph Hinkle on 9/18/21.
//

public protocol KnownConformance {
    func onReceive(info: Any) throws -> AnyWithTypeWrapper
    static func attemptCast(_ val: Any) throws -> KnownConformance
}

extension KnownConformance {
    static func attemptCast(_ val: Any) throws -> KnownConformance {
        if let val = val as? Self {
            return val
        }
        throw TypeWrapperError.mismatch
    }
}

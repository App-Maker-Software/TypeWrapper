//
//  ProtocolWithAssociateType.swift
//  
//
//  Created by Joseph Hinkle on 9/19/21.
//

import TypeWrapper
import SwiftUI

//
// implement for protocol with associated type
//
extension TypeWrapper {
    func makeRed(_ someView: Any) throws -> AnyWithTypeWrapper {
        try self.send(someView, as: {
            ($0 as? _SwiftUIView)?.onReceive(input:)
        })
    }
}
protocol _SwiftUIView {
    func onReceive(input: Any) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _SwiftUIView where Wrapped: View {
    public func onReceive(input: Any) throws -> AnyWithTypeWrapper {
        let redView = (input as! Wrapped).foregroundColor(.red)
        return addTypeWrapper(redView)
    }
}

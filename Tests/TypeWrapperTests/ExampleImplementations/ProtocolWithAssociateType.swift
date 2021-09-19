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
        try self.attempt {
            ($0 as? _SwiftUIView)?.onReceive(input: someView)
        }
    }
}
protocol _SwiftUIView {
    func onReceive(input: Any) -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _SwiftUIView where Wrapped: View {
    public func onReceive(input: Any) -> AnyWithTypeWrapper {
        let view = input as! Wrapped
        let redView = view.foregroundColor(.red)
        return addTypeWrapper(redView)
    }
}

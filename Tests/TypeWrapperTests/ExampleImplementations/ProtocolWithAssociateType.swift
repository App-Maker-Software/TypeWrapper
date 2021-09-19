//
//  ProtocolWithAssociateType.swift
//  
//
//  Created by Joseph Hinkle on 9/19/21.
//

import TypeWrapper
import SwiftUI

//
// add method to view
//
extension TypeWrapper {
    func makeRed(_ someView: Any) throws -> AnyWithTypeWrapper {
        try self.send(someView, as: {
            ($0 as? _SwiftUIView)?.onReceive(info:)
        })
    }
}
protocol _SwiftUIView {
    func onReceive(info: Any) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _SwiftUIView where Wrapped: View {
    public func onReceive(info: Any) throws -> AnyWithTypeWrapper {
        let redView = (info as! Wrapped).foregroundColor(.red)
        return addTypeWrapper(redView)
    }
}

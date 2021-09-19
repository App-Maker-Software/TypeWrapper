//
//  ArbitraryGenericBuilderTypeWrapperSupport.swift
//  
//
//  Created by Joseph Hinkle on 9/19/21.
//

// lets us talk to ArbitraryGenericBuilder via the TypeWrapper pattern

extension TypeWrapper {
    func addToGenericRegister<T>(genericBuilder: Any, type: T.Type) throws -> AnyWithTypeWrapper {
        try self.send(AddToGenericRegisterInfo(
            genericBuilder: genericBuilder,
            type: type
        ), as: {
            ($0 as? __GenericRegister)?.onReceive(input:)
        })
    }
}
struct AddToGenericRegisterInfo {
    let genericBuilder: Any
    func addTypeTo<T: GenericBuilder>(builder: T) -> AnyWithTypeWrapper {
        fatalError()
        builder.add(type: <#T##T.Type#>)
    }
    init<T>(genericBuilder: Any, type: T.Type) {
        self.genericBuilder = genericBuilder
    }
}
protocol __GenericRegister {
    func onReceive(input: Any) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: __GenericRegister where Wrapped: GenericBuilder {
    func onReceive(input: Any) throws -> AnyWithTypeWrapper {
        let addToGenericRegisterInfo = input as! AddToGenericRegisterInfo
        let genericBuilder: Wrapped = addToGenericRegisterInfo.genericBuilder as! Wrapped
        return addToGenericRegisterInfo.addTypeTo(builder: genericBuilder)
    }
}

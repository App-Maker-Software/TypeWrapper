//
//  ArbitraryGenericBuilderTypeWrapperSupport.swift
//  
//
//  Created by Joseph Hinkle on 9/19/21.
//

// lets us talk to ArbitraryGenericBuilder via the TypeWrapper pattern

extension TypeWrapper {
    func addToGenericRegister<T>(genericBuilder: Any, type: T.Type) throws -> AnyWithTypeWrapper {
        func _usingGenericBuilder<GB: GenericBuilder>(gb: GB) {
            
        }
        
        return try self.send(AddToGenericRegisterInfo(
            genericBuilder: genericBuilder,
            type: type
        ), as: {
            try! ($0 as? _GenericBuilder)?.onReceive2(input: type)
            fatalError()
        })
    }
}
struct AddToGenericRegisterInfo {
    let genericBuilder: Any
    let type: TypeWrapper
    func addTypeTo<T: GenericBuilder>(builder: T) -> AnyWithTypeWrapper {
        fatalError()
    }
    init<T>(genericBuilder: Any, type: T.Type) {
        self.genericBuilder = genericBuilder
        self.type = TypeWrapper(withType: type)
    }
}
protocol _GenericBuilder {
    func onReceive(input: Any) throws -> AnyWithTypeWrapper
    func onReceive2<T>(input: T) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _GenericBuilder where Wrapped: GenericBuilder {
    func onReceive(input: Any) throws -> AnyWithTypeWrapper {
        let addToGenericRegisterInfo = input as! AddToGenericRegisterInfo
        let genericBuilder: Wrapped = addToGenericRegisterInfo.genericBuilder as! Wrapped
        return addToGenericRegisterInfo.addTypeTo(builder: genericBuilder)
    }
    func onReceive2<T>(input: T) throws -> AnyWithTypeWrapper {
        print(T.self)
        fatalError()
//        let addToGenericRegisterInfo = input as! AddToGenericRegisterInfo
//        let genericBuilder: Wrapped = addToGenericRegisterInfo.genericBuilder as! Wrapped
//        return addToGenericRegisterInfo.addTypeTo(builder: genericBuilder)
    }
}

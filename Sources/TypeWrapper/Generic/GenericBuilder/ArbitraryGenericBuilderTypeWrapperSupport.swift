//
//  ArbitraryGenericBuilderTypeWrapperSupport.swift
//  
//
//  Created by Joseph Hinkle on 9/19/21.
//

// lets us talk to ArbitraryGenericBuilder via the TypeWrapper pattern

extension TypeWrapper {
    func addToGenericRegister<T>(genericBuilder: Any, type: T.Type) throws -> AnyWithTypeWrapper {        
        return try self.attempt {
            ($0 as? _GenericBuilder)?.addType(genericBuilder: genericBuilder, type: type)
        }
    }
}
protocol _GenericBuilder {
    func addType<T>(genericBuilder: Any, type: T.Type) -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _GenericBuilder where Wrapped: GenericBuilder {
    func addType<T>(genericBuilder: Any, type: T.Type) -> AnyWithTypeWrapper {
        let genericBuilder: Wrapped = genericBuilder as! Wrapped
        return genericBuilder.add(type: type)
    }
}

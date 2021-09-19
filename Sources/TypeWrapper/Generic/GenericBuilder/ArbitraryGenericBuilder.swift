//
//  ArbitraryGenericBuilder.swift
//  
//
//  Created by Joseph Hinkle on 9/19/21.
//

// lets you create a group of generics at runtime
public struct ArbitraryGenericBuilder {
    private var genericBuilder: AnyWithTypeWrapper
    
    public func add<T>(type: T.Type) -> ArbitraryGenericBuilder {
        var new = self
        new.genericBuilder = try! genericBuilder.typeWrapper.addToGenericRegister(
            genericBuilder: genericBuilder.any,
            type: type
        )
        return new
    }
    
    public func getBuilt() -> TypeWrapper {
        return genericBuilder.typeWrapper
    }
    
    public init() {
        self.genericBuilder = addTypeWrapper(_NonGeneric())
    }
}

//
//  GenericBuilders.swift
//  
//
//  Created by Joseph Hinkle on 9/19/21.
//

protocol GenericBuilder: _GenericRegister {
    // must return another generic builder
    func add<T>(type: T.Type) -> AnyWithTypeWrapper
}

extension _NonGeneric: GenericBuilder {
    func add<T0>(type: T0.Type) -> AnyWithTypeWrapper {
        addTypeWrapper(GenericBuilder1<T0>())
    }
}

struct GenericBuilder1<T0>: Register1Generic, GenericBuilder {
    public typealias Generic0 = T0
    func add<T1>(type: T1.Type) -> AnyWithTypeWrapper {
        addTypeWrapper(GenericBuilder2<T0, T1>())
    }
}
struct GenericBuilder2<T0, T1>: Register2Generics, GenericBuilder {
    public typealias Generic0 = T0
    public typealias Generic1 = T1
    func add<T2>(type: T2.Type) -> AnyWithTypeWrapper {
        addTypeWrapper(GenericBuilder3<T0, T1, T2>())
    }
}
struct GenericBuilder3<T0, T1, T2>: Register3Generics, GenericBuilder {
    public typealias Generic0 = T0
    public typealias Generic1 = T1
    public typealias Generic2 = T2
    func add<T3>(type: T3.Type) -> AnyWithTypeWrapper {
        addTypeWrapper(GenericBuilder4<T0, T1, T2, T3>())
    }
}
struct GenericBuilder4<T0, T1, T2, T3>: Register4Generics, GenericBuilder {
    public typealias Generic0 = T0
    public typealias Generic1 = T1
    public typealias Generic2 = T2
    public typealias Generic3 = T3
    func add<T4>(type: T4.Type) -> AnyWithTypeWrapper {
        addTypeWrapper(GenericBuilder5<T0, T1, T2, T3, T4>())
    }
}
struct GenericBuilder5<T0, T1, T2, T3, T4>: _GenericRegister, GenericBuilder {
    public typealias Generic0 = T0
    public typealias Generic1 = T1
    public typealias Generic2 = T2
    public typealias Generic3 = T3
    public typealias Generic4 = T4
    func add<T5>(type: T5.Type) -> AnyWithTypeWrapper {
        fatalError("we don't support more than 5 generics yet")
    }
}

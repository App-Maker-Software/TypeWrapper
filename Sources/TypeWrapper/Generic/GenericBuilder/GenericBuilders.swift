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
struct GenericBuilder5<T0, T1, T2, T3, T4>: Register5Generics, GenericBuilder {
    public typealias Generic0 = T0
    public typealias Generic1 = T1
    public typealias Generic2 = T2
    public typealias Generic3 = T3
    public typealias Generic4 = T4
    func add<T5>(type: T5.Type) -> AnyWithTypeWrapper {
        addTypeWrapper(GenericBuilder6<T0, T1, T2, T3, T4, T5>())
    }
}

struct GenericBuilder6<T0, T1, T2, T3, T4, T5>: Register6Generics, GenericBuilder {
    public typealias Generic0 = T0
    public typealias Generic1 = T1
    public typealias Generic2 = T2
    public typealias Generic3 = T3
    public typealias Generic4 = T4
    public typealias Generic5 = T5
    func add<T6>(type: T6.Type) -> AnyWithTypeWrapper {
        addTypeWrapper(GenericBuilder7<T0, T1, T2, T3, T4, T5, T6>())
    }
}

struct GenericBuilder7<T0, T1, T2, T3, T4, T5, T6>: Register7Generics, GenericBuilder {
    public typealias Generic0 = T0
    public typealias Generic1 = T1
    public typealias Generic2 = T2
    public typealias Generic3 = T3
    public typealias Generic4 = T4
    public typealias Generic5 = T5
    public typealias Generic6 = T6
    func add<T7>(type: T7.Type) -> AnyWithTypeWrapper {
        addTypeWrapper(GenericBuilder8<T0, T1, T2, T3, T4, T5, T6, T7>())
    }
}

struct GenericBuilder8<T0, T1, T2, T3, T4, T5, T6, T7>: Register8Generics, GenericBuilder {
    public typealias Generic0 = T0
    public typealias Generic1 = T1
    public typealias Generic2 = T2
    public typealias Generic3 = T3
    public typealias Generic4 = T4
    public typealias Generic5 = T5
    public typealias Generic6 = T6
    public typealias Generic7 = T7
    func add<T8>(type: T8.Type) -> AnyWithTypeWrapper {
        addTypeWrapper(GenericBuilder9<T0, T1, T2, T3, T4, T5, T6, T7, T8>())
    }
}

struct GenericBuilder9<T0, T1, T2, T3, T4, T5, T6, T7, T8>: Register9Generics, GenericBuilder {
    public typealias Generic0 = T0
    public typealias Generic1 = T1
    public typealias Generic2 = T2
    public typealias Generic3 = T3
    public typealias Generic4 = T4
    public typealias Generic5 = T5
    public typealias Generic6 = T6
    public typealias Generic7 = T7
    public typealias Generic8 = T8
    func add<T9>(type: T9.Type) -> AnyWithTypeWrapper {
        addTypeWrapper(GenericBuilder10<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9>())
    }
}

struct GenericBuilder10<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9>: _GenericRegister, GenericBuilder {
    public typealias Generic0 = T0
    public typealias Generic1 = T1
    public typealias Generic2 = T2
    public typealias Generic3 = T3
    public typealias Generic4 = T4
    public typealias Generic5 = T5
    public typealias Generic6 = T6
    public typealias Generic7 = T7
    public typealias Generic8 = T8
    public typealias Generic9 = T9
    func add<T10>(type: T10.Type) -> AnyWithTypeWrapper {
        fatalError("we don't support more than 10 generics yet")
    }
}

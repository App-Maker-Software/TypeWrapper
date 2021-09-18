import XCTest
import SwiftUI
@testable import TypeWrapper

//
// add method to int
//
extension TypeWrapper {
    func addSevenToInt(_ anyInt: Any) throws -> AnyWithTypeWrapper {
        try self.send(anyInt, as: {
            ($0 as? _SwiftInt)?.onReceive(info:)
        })
    }
}
protocol _SwiftInt {
    func onReceive(info: Any) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _SwiftInt where Wrapped == Int {
    public func onReceive(info: Any) throws -> AnyWithTypeWrapper {
        let int = info as! Int + 7
        return addTypeWrapper(int)
    }
}
//
// add method to double
//
extension TypeWrapper {
    func addSevenToDouble(_ anyDouble: Any) throws -> AnyWithTypeWrapper {
        try self.send(anyDouble, as: {
            ($0 as? _SwiftDouble)?.onReceive(info:)
        })
    }
}
protocol _SwiftDouble {
    func onReceive(info: Any) throws -> AnyWithTypeWrapper
}
extension AttemptIfConformsStruct: _SwiftDouble where Wrapped == Double {
    public func onReceive(info: Any) throws -> AnyWithTypeWrapper {
        let double = info as! Double + 7
        return addTypeWrapper(double)
    }
}

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

struct CustomTypeWithGenericFloatingPoint<T: FloatingPoint> {
    let floatingPointValue: T
}

extension CustomTypeWithGenericFloatingPoint: GenericRegister {
    typealias Generic0 = T
}

final class TypeWrapperTests: XCTestCase {
    func testInt() throws {
        // normal
        let int: Int = 5
        let normalResult = int + 7
        
        // without using type directly
        let (anyInt, typeWrapper) = addTypeWrapper(int)
        let (indirectResult, _) = try typeWrapper.addSevenToInt(anyInt)
        
        XCTAssertEqual("\(normalResult)", "\(indirectResult)")
        
        // should fail here
        do {
            _ = try typeWrapper.addSevenToDouble(anyInt)
            XCTFail()
        } catch {}
    }
    func testDouble() throws {
        // normal
        let double: Double = 5
        let normalResult = double + 7
        
        // without using type directly
        let (anyDouble, typeWrapper) = addTypeWrapper(double)
        let (indirectResult, _) = try typeWrapper.addSevenToDouble(anyDouble)
        
        XCTAssertEqual("\(normalResult)", "\(indirectResult)")
        
        // should fail here
        do {
            _ = try typeWrapper.addSevenToInt(anyDouble)
            XCTFail()
        } catch {}
    }
    func testSwiftUIView() throws {
        // normal
        let someView: some View = Text("Hello world")
        let normalResult = someView.foregroundColor(.red)
        
        // without using type directly
        let (anyConcreteView, typeWrapper) = addTypeWrapper(someView)
        let (indirectResult, _) = try typeWrapper.makeRed(anyConcreteView)
        
        XCTAssertEqual("\(normalResult)", "\(indirectResult)")
        
        // should fail here
        do {
            _ = try typeWrapper.addSevenToInt(anyConcreteView)
            XCTFail()
        } catch {}
    }
}

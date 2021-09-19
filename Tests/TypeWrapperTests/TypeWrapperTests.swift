import XCTest
import SwiftUI
@testable import TypeWrapper

final class TypeWrapperTests: XCTestCase {
    func testInt() throws {
        // normal
        let int: Int = 5
        let normalResult = int + 7
        
        // without using type directly
        let anyIntWithTypeWrapper = addTypeWrapper(int)
        let anyIntWithTypeWrapperModified = try anyIntWithTypeWrapper.typeWrapper.addSevenToInt(anyIntWithTypeWrapper.any)
        
        XCTAssertEqual("\(normalResult)", "\(anyIntWithTypeWrapperModified.any)")
        
        // should fail here
        do {
            _ = try anyIntWithTypeWrapper.typeWrapper.addSevenToDouble(anyIntWithTypeWrapper.any)
            XCTFail()
        } catch {}
    }
    func testDouble() throws {
        // normal
        let double: Double = 5
        let normalResult = double + 7
        
        // without using type directly
        let anyDoubleWithTypeWrapper = addTypeWrapper(double)
        let anyDoubleWithTypeWrapperModified = try anyDoubleWithTypeWrapper.typeWrapper.addSevenToDouble(anyDoubleWithTypeWrapper.any)
        
        XCTAssertEqual("\(normalResult)", "\(anyDoubleWithTypeWrapperModified.any)")
        
        // should fail here
        do {
            _ = try anyDoubleWithTypeWrapper.typeWrapper.addSevenToInt(anyDoubleWithTypeWrapper.any)
            XCTFail()
        } catch {}
        do {
            _ = try anyDoubleWithTypeWrapper.typeWrapper.add12Point4ToGenericType(anyDoubleWithTypeWrapper.any)
            XCTFail()
        } catch {}
    }
    func testSwiftUIView() throws {
        // normal
        let someView: some View = Text("Hello world")
        let normalResult = someView.foregroundColor(.red)
        
        // without using type directly
        let anyWithTypeWrapper = addTypeWrapper(someView)
        let anyWithTypeWrapperModified = try anyWithTypeWrapper.typeWrapper.makeRed(anyWithTypeWrapper.any)
        
        XCTAssertEqual("\(normalResult)", "\(anyWithTypeWrapperModified.any)")
        
        // should fail here
        do {
            _ = try anyWithTypeWrapper.typeWrapper.addSevenToInt(anyWithTypeWrapper.any)
            XCTFail()
        } catch {}
        do {
            _ = try anyWithTypeWrapper.typeWrapper.add12Point4ToGenericType(anyWithTypeWrapper.any)
            XCTFail()
        } catch {}
    }
    func testMultipleSwiftUIViews() throws {
        // make array of different views
        var array: [AnyWithTypeWrapper] = []
        for i in 0..<100 {
            if i % 2 == 1 {
                let view = Button("click me") { print("hi") }
                array.append(addTypeWrapper(view))
            } else {
                let view = Text("hello")
                array.append(addTypeWrapper(view))
            }
        }
        
        // make them all red without use of "AnyView"
        for i in 0..<array.count {
            let el = array[i]
            array[i] = try el.typeWrapper.makeRed(el.any)
        }
        
        // make sure other methods don't work
        for i in 0..<array.count {
            let el = array[i]
            do {
                _ = try el.typeWrapper.addSevenToInt(el.any)
                XCTFail()
            } catch {}
            do {
                _ = try el.typeWrapper.addSevenToDouble(el.any)
                XCTFail()
            } catch {}
            do {
                _ = try el.typeWrapper.add12Point4ToGenericType(el.any)
                XCTFail()
            } catch {}
        }
    }
    func testGenericType() throws {
        // normal
        let genericType1 = CustomTypeWithGenericFloatingPoint(floatingPointValue: Double(5.5))
        let normalResult1 = genericType1.floatingPointValue + 12.4
        let genericType2 = CustomTypeWithGenericFloatingPoint(floatingPointValue: CGFloat(2.5))
        let normalResult2 = genericType2.floatingPointValue + 12.4
        
        // without using type directly
        let anyWithTypeWrapper1 = addTypeWrapper(genericType1)
        let anyWithTypeWrapper1Modified = try anyWithTypeWrapper1.typeWrapper.add12Point4ToGenericType(anyWithTypeWrapper1.any)
        let anyWithTypeWrapper2 = addTypeWrapper(genericType2)
        let anyWithTypeWrapper2Modified = try anyWithTypeWrapper2.typeWrapper.add12Point4ToGenericType(anyWithTypeWrapper2.any)
        
        XCTAssertEqual("\(normalResult1)", "\(anyWithTypeWrapper1Modified.any)")
        XCTAssertEqual("\(normalResult2)", "\(anyWithTypeWrapper2Modified.any)")
        XCTAssertNotEqual("\(normalResult1)", "\(normalResult2)")
        XCTAssertNotEqual("\(anyWithTypeWrapper1Modified.any)", "\(anyWithTypeWrapper2Modified.any)")
        
        // should fail here
        do {
            _ = try anyWithTypeWrapper1.typeWrapper.addSevenToInt(anyWithTypeWrapper1.any)
            XCTFail()
        } catch {}
        do {
            _ = try anyWithTypeWrapper2.typeWrapper.addSevenToInt(anyWithTypeWrapper2.any)
            XCTFail()
        } catch {}
        do {
            _ = try anyWithTypeWrapper1.typeWrapper.addSevenToDouble(anyWithTypeWrapper1.any)
            XCTFail()
        } catch {}
        do {
            _ = try anyWithTypeWrapper2.typeWrapper.addSevenToDouble(anyWithTypeWrapper2.any)
            XCTFail()
        } catch {}
    }
    func testArbitraryGenericBuilder() throws {
        let goodValue1_1: Double = 3
        let goodValue1_2: Text = Text("hello")
        let goodValue2_1: CGFloat = 3
        let goodValue2_2: Slider<EmptyView, EmptyView> = Slider(value: .constant(0))
        let value1 = GenericFuncsTest(value: goodValue1_1, view: goodValue1_2)
        let value2 = GenericFuncsTest(value: goodValue2_1, view: goodValue2_2)
        let expectedType1 = type(of: value1)
        let expectedType2 = type(of: value2)
        
        let a = ArbitraryGenericBuilder()
            .add(type: type(of: goodValue1_1))
            .add(type: type(of: goodValue1_2))
            .getBuilt()
        fatalError("\(a.any)")
//        XCTAssertEqual(expectedType1, a.any)
    }
    func testGenericInit() throws {
        let goodValue1_1: Double = 3
        let goodValue1_2: Text = Text("hello")
        let goodValue2_1: CGFloat = 3
        let goodValue2_2: Slider<EmptyView, EmptyView> = Slider(value: .constant(0))
        let goodValue3_1: Float = 3
        let goodValue3_2: EmptyView = EmptyView()
        let badValue1: Int = 3
        let badValue2: Bool = false
        let badValue3: String = ""
        
        let result1 = GenericFuncsTest(value: goodValue1_1, view: goodValue1_2)
        let result2 = GenericFuncsTest(value: goodValue2_1, view: goodValue2_2)
        let result3 = GenericFuncsTest(value: goodValue3_1, view: goodValue3_2)
        
//        let ok = GenericFuncsTest.self
//        let customTypeWithGenericFloatingPoint: TypeWrapper = TypeWrapper(withType: CustomTypeWithGenericFloatingPoint<<#T: ExpressibleByFloatLiteral & FloatingPoint#>>.self)
        
        
    }
    func testMoreOptionsExample() throws {
        let bool1 = false
        let bool2 = true
        
        let and = bool1 && bool2
        let or = bool1 || bool2
        
        let anyBool1: AnyWithTypeWrapper = addTypeWrapper(bool1)
        let anyBool2: AnyWithTypeWrapper = addTypeWrapper(bool2)
        
        let andResult = try anyBool1.typeWrapper.boolMoreOptions(_BoolExtraOptions(someBool: anyBool1.any, otherBool: anyBool2.any, op: "&&"))
        let orResult = try anyBool1.typeWrapper.boolMoreOptions(_BoolExtraOptions(someBool: anyBool1.any, otherBool: anyBool2.any, op: "||"))
        
        XCTAssertEqual("\(and)", "\(andResult.any)")
        XCTAssertEqual("\(or)", "\(orResult.any)")
    }
//    func testClosures() throws {
//        let closure1: (Bool) -> Bool = {!$0}
//        let closure2: (Int) -> Int = {$0 * 3}
//
//        let input1: Bool = false
//        let input2: Int = 3
//
//        let result1 = closure1(input1)
//        let result2 = closure2(input2)
//
//        let anyClosure1: AnyWithTypeWrapper = addTypeWrapper(closure1)
//        let anyClosure2: AnyWithTypeWrapper = addTypeWrapper(closure2)
//
//        let andResult = try anyBool1.typeWrapper.boolMoreOptions(_BoolExtraOptions(someBool: anyBool1.any, otherBool: anyBool2.any, op: "&&"))
//        let orResult = try anyBool1.typeWrapper.boolMoreOptions(_BoolExtraOptions(someBool: anyBool1.any, otherBool: anyBool2.any, op: "||"))
//
//        XCTAssertEqual("\(and)", "\(andResult.any)")
//        XCTAssertEqual("\(or)", "\(orResult.any)")
//    }
}

import XCTest
import SwiftUI
@testable import TypeWrapper

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
            _ = try typeWrapper.add12Point4ToGenericType(anyDouble)
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
            _ = try typeWrapper.add12Point4ToGenericType(anyConcreteView)
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
                _ = try el.typeWrapper.addSevenToDouble(el.any)
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
        let (erasedValue1, typeWrapper1) = addTypeWrapper(genericType1)
        let (indirectResult1, _) = try typeWrapper1.add12Point4ToGenericType(erasedValue1)
        let (erasedValue2, typeWrapper2) = addTypeWrapper(genericType2)
        let (indirectResult2, _) = try typeWrapper2.add12Point4ToGenericType(erasedValue2)
        
        XCTAssertEqual("\(normalResult1)", "\(indirectResult1)")
        XCTAssertEqual("\(normalResult2)", "\(indirectResult2)")
        XCTAssertNotEqual("\(normalResult1)", "\(normalResult2)")
        XCTAssertNotEqual("\(indirectResult1)", "\(indirectResult2)")
        
        // should fail here
        do {
            _ = try typeWrapper1.addSevenToInt(erasedValue1)
            _ = try typeWrapper2.addSevenToInt(erasedValue2)
            _ = try typeWrapper1.addSevenToDouble(erasedValue1)
            _ = try typeWrapper2.addSevenToDouble(erasedValue2)
            XCTFail()
        } catch {}
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
}

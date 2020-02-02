import XCTest
import DataStructure

class StackTests: XCTestCase {
    
    var sut: Stack<Int>!
    
    override func setUp() {
        super.setUp()
        sut = Stack<Int>(capacity: 3)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_push_pop() {
        sut.push(1)
        XCTAssert(sut.pop() == 1)
    }
    
    func test_peek() {
        sut.push(1)
        sut.push(2)
        XCTAssert(sut.peek() == 2)
    }
    
    func test_count() {
        sut.push(1)
        XCTAssert(sut.count == 1)
        sut.push(2)
        XCTAssert(sut.count == 2)
    }
    
    func test_isEmpty() {
        XCTAssert(sut.isEmpty == true)
        sut.push(1)
        XCTAssert(sut.isEmpty == false)
    }
    
    func test_push_autoResize() {
        sut.push(1)
        sut.push(2)
        sut.push(3)
        sut.push(4)
        XCTAssert(sut.count == 4)
        XCTAssert(sut.peek() == 4)
        XCTAssert(sut.pop() == 4)
        XCTAssert(sut.peek() == 3)
    }
    
    func test_clear_releaseMemory() {
        sut.push(1)
        sut.push(2)
        sut.push(3)
        sut.push(4)
        sut.clear()
        XCTAssert(sut.count == 0)
        XCTAssert(sut.peek() == nil)
    }
    
    func test_clear_notReleaseMemory() {
        sut.push(1)
        sut.push(2)
        sut.push(3)
        sut.push(4)
        sut.clear(false)
        XCTAssert(sut.count == 0)
        XCTAssert(sut.peek() == nil)
    }
    
    func test_customStringConvertible() {
        sut.push(1)
        XCTAssert(sut.description == [1].description)
        sut.push(2)
        XCTAssert(sut.description == [1, 2].description)
        sut.push(3)
        sut.pop()
        XCTAssert(sut.description == [1,2].description)
    }
    
    func test_expressByArrayLiteral() {
        sut = [1, 2, 3]
        XCTAssert([1, 2, 3].description == sut.description)
        sut.pop()
        XCTAssert(sut.description == [1, 2].description)
        XCTAssert(sut[0] == 1)
    }
}
